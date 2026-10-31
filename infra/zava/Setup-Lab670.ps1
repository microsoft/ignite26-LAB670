#Requires -Version 7.2
[CmdletBinding()]
param(
    [ValidateSet('Plan', 'Apply', 'Verify')][string]$Phase = 'Plan',
    [Parameter(Mandatory)][string]$Bundle,
    [string]$Config,
    [string]$SourceDirectory,
    [string]$Python = 'python',
    [Alias('SkillableTenantId')][string]$TenantId,
    [string]$ApprovedPlanSha256,
    [string]$ApprovalText,
    [ValidateRange(30, 3600)][int]$MaxWaitSeconds = 1200
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$revision = '1d8fc2570dc51eed259389df6ff4c807dada40ea'
$expectedArchiveHash = '0dc2e656c96085cfc88cf5378a951c136b4f49506184bc9b61a71bcb4347adb2'
$labRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))
$Bundle = [IO.Path]::GetFullPath($Bundle)
if (-not $SourceDirectory) { $SourceDirectory = "$Bundle-source" }
$SourceDirectory = [IO.Path]::GetFullPath($SourceDirectory)
foreach ($path in @($Bundle, $SourceDirectory)) {
    if ($path -eq $labRoot -or $path.StartsWith($labRoot + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase)) {
        throw 'Generated content and source cache must remain outside the lab repository.'
    }
}
if ($Phase -ne 'Plan') {
    if (-not $ApprovedPlanSha256) { throw 'Live phases require the exact approved resource/action plan hash.' }
    $tenant = [guid]::Empty
    if (-not [guid]::TryParse($TenantId, [ref]$tenant) -or $tenant -eq [guid]::Empty) {
        throw 'Live phases require the exact approved tenant GUID. A profile number or environment label is not a tenant GUID.'
    }
    $boundConfig = Get-Content -LiteralPath (Join-Path $Bundle 'config.json') -Raw | ConvertFrom-Json
    if ($boundConfig.tenantId -ne $TenantId) { throw 'STOP: configuration is not bound to the approved tenant.' }
    if ($Config) { throw 'Use the approved bundle configuration for live phases; create a new Plan to change it.' }
}
$null = New-Item -ItemType Directory -Path $SourceDirectory -Force
$archivePath = Join-Path $SourceDirectory 'context-source.zip'
$sourceRoot = Join-Path $SourceDirectory "zava-enterprise-context-$revision"
if (-not (Test-Path -LiteralPath $archivePath)) {
    Invoke-WebRequest -Uri "https://codeload.github.com/santhoshravindran7/zava-enterprise-context/zip/$revision" -OutFile $archivePath
}
if ((Get-FileHash -LiteralPath $archivePath).Hash -ne $expectedArchiveHash) {
    throw 'Pinned source archive checksum mismatch. Do not execute it; obtain a reviewed pin update.'
}
$archive = [IO.Compression.ZipFile]::OpenRead($archivePath)
try {
    foreach ($entry in $archive.Entries) {
        $destination = [IO.Path]::GetFullPath((Join-Path $SourceDirectory $entry.FullName.Replace('/', [IO.Path]::DirectorySeparatorChar)))
        if (-not $destination.StartsWith($SourceDirectory + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase) -or
            (($entry.ExternalAttributes -shr 16) -band 0xF000) -eq 0xA000) {
            throw 'Unsafe archive path or symbolic link.'
        }
    }
    if (-not (Test-Path -LiteralPath $sourceRoot)) {
        Expand-Archive -LiteralPath $archivePath -DestinationPath $SourceDirectory
    }
    foreach ($entry in $archive.Entries) {
        if ($entry.FullName.EndsWith('/')) { continue }
        $destination = Join-Path $SourceDirectory $entry.FullName.Replace('/', [IO.Path]::DirectorySeparatorChar)
        $stream = $entry.Open()
        $sha = [Security.Cryptography.SHA256]::Create()
        try { $expected = [Convert]::ToHexString($sha.ComputeHash($stream)) }
        finally { $stream.Dispose(); $sha.Dispose() }
        if ((Get-FileHash -LiteralPath $destination).Hash -ne $expected) {
            throw "Cached source changed: $($entry.FullName). No source code was executed."
        }
    }
} finally { $archive.Dispose() }
$arguments = @{Phase = $Phase; Bundle = $Bundle; Python = $Python; MaxWaitSeconds = $MaxWaitSeconds}
if ($Phase -eq 'Plan') {
    $arguments.Config = if ($Config) { $Config } else { Join-Path $sourceRoot 'infra\zava\environment.template.json' }
} else {
    $arguments.ApprovedPlanSha256 = $ApprovedPlanSha256
    if ($ApprovalText) { $arguments.ApprovalText = $ApprovalText }
}
& (Join-Path $sourceRoot 'infra\zava\Setup-Zava.ps1') @arguments
if ($LASTEXITCODE -ne 0) { throw 'Pinned enterprise setup failed; no native readiness claim is made.' }
$receipt = @{
    repository = 'https://github.com/santhoshravindran7/zava-enterprise-context'
    revision = $revision; archiveSha256 = $expectedArchiveHash
    phase = $Phase; observedAt = [DateTimeOffset]::UtcNow.ToString('o')
    nativeValidation = 'SEE_PRIVATE_READINESS_REPORT_NOT_LOCAL_TESTS'
}
$receipt | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $SourceDirectory 'dependency.private.json') -Encoding utf8
