#Requires -Version 7.2
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$entry = Join-Path (Split-Path $PSScriptRoot -Parent) 'Setup-Lab670.ps1'
$temporary = Join-Path ([IO.Path]::GetTempPath()) ('lab670-binding-test-' + [guid]::NewGuid().ToString('N'))
$null = New-Item -ItemType Directory -Path $temporary
$bundle = Join-Path $temporary 'bundle'
$cache = Join-Path $temporary 'source'
$null = New-Item -ItemType Directory -Path $bundle, $cache
$tenant = '11111111-1111-1111-1111-111111111111'
@{tenantId = $tenant} | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $bundle 'config.json')
[IO.File]::WriteAllText((Join-Path $cache 'context-source.zip'), 'deliberately-invalid-cache')
function Assert-Throws([scriptblock]$Action, [string]$Expected) {
    $failed = $false
    try { & $Action } catch {
        if ($_.Exception.Message -notmatch $Expected) { throw }
        $failed = $true
    }
    if (-not $failed) { throw "Expected rejection: $Expected" }
}
try {
    $argsCommon = @{Phase = 'Verify'; Bundle = $bundle; SourceDirectory = $cache; ApprovedPlanSha256 = 'a' * 64}
    Assert-Throws { & $entry @argsCommon } 'approved tenant GUID'
    Assert-Throws { & $entry @argsCommon -TenantId '225730' } 'approved tenant GUID'
    Assert-Throws { & $entry @argsCommon -TenantId '22222222-2222-2222-2222-222222222222' } 'not bound'
    Assert-Throws { & $entry @argsCommon -SkillableTenantId '22222222-2222-2222-2222-222222222222' } 'not bound'
    Assert-Throws { & $entry @argsCommon -TenantId $tenant } 'checksum mismatch'
    Assert-Throws { & $entry @argsCommon -SkillableTenantId $tenant } 'checksum mismatch'
    Write-Output 'PASS: explicit generic tenant binding, legacy Skillable alias, profile-ID rejection and fail-closed cached source. ZERO network calls.'
} finally {
    $resolved = (Resolve-Path -LiteralPath $temporary).Path
    if ([IO.Path]::GetFileName($resolved) -notmatch '^lab670-binding-test-[a-f0-9]{32}$') { throw 'Refusing unexpected test cleanup path.' }
    Remove-Item -LiteralPath $resolved -Recurse
}
