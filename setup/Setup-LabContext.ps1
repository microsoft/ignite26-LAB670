#Requires -Version 7.2
[CmdletBinding()]
param(
    [ValidateSet('SignUp', 'Plan', 'Apply', 'Verify')]
    [string]$Phase = 'Plan',
    [string]$ConfigPath = (Join-Path $PSScriptRoot 'tenant.quick.template.json'),
    [string]$BundlePath,
    [string]$ApprovedPlanSha256,
    [string]$ApprovalText,
    [ValidateRange(60, 600)]
    [int]$MaxSetupSeconds = 600
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$runtime = Join-Path $PSScriptRoot 'infra\zava'

if ($Phase -eq 'SignUp') {
    Write-Output 'Sign in with the issued Skillable lab account, NOT your personal/company account.'
    Write-Output 'Complete the displayed first-time Fabric registration form and review/accept terms yourself if authorized. Fields vary; do not invent organization details.'
    Write-Output 'Wait for Fabric Home. This does not create capacity or enable ScoringApp. Do not start a trial or buy capacity unless explicitly instructed by the organizer.'
    Start-Process 'https://app.fabric.microsoft.com'
    Write-Output 'After completing the browser flow, follow instructions/lab-setup.md. No sign-up completion is inferred by this script.'
    exit 0
}
if (-not $BundlePath -or -not [IO.Path]::IsPathFullyQualified($BundlePath)) {
    throw 'Specify an absolute -BundlePath outside the lab checkout. Plan requires a NEW output directory.'
}
if ($Phase -eq 'Plan') {
    if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
        throw 'Python 3.11+ must be in the approved lab image; setup never installs tools.'
    }
    & python -c "import sys; assert sys.version_info >= (3,11), 'Python 3.11+ required'"
    if ($LASTEXITCODE -ne 0) { throw 'Python 3.11+ is required.' }
    & python -B (Join-Path $runtime 'build_quick.py') --config $ConfigPath --output $BundlePath
    if ($LASTEXITCODE -ne 0) { throw 'Offline plan generation failed. Preserve incomplete output and use a NEW path after fixing the error.' }
    Get-Content -LiteralPath (Join-Path $BundlePath 'PLAN.md')
    Write-Output "Plan SHA256: $((Get-FileHash -LiteralPath (Join-Path $BundlePath 'plan.json')).Hash)"
    Write-Output 'OFFLINE ONLY: no sign-in, tenant write, dependency install or client change occurred.'
    exit 0
}
if (-not $ApprovedPlanSha256) { throw 'Apply/Verify require the exact reviewed -ApprovedPlanSha256.' }
Import-Module (Join-Path $runtime 'Zava.psm1') -Force
Initialize-Zava $BundlePath $MaxSetupSeconds
Assert-ZavaBundle $ApprovedPlanSha256
$plan = Read-ZavaJson (Join-Path $BundlePath 'plan.json')
if ($plan.profile -ne 'LAB670-Quick' -or
    (Get-FileHash -LiteralPath $PSCommandPath).Hash -ne $plan.entrypointSha256) {
    throw 'Wrong plan profile or entrypoint changed. Rebuild and obtain fresh approval.'
}
if ($Phase -eq 'Apply') {
    $required = "APPLY $ApprovedPlanSha256"
    if (-not $ApprovalText) {
        $ApprovalText = Read-Host "After reviewing targets, actions and costs, type: $required"
    }
    if ($ApprovalText -cne $required) { throw 'Approval phrase mismatch. No live operations attempted.' }
}
if ($Phase -eq 'Verify' -and -not (Test-Path -LiteralPath (Join-Path $BundlePath 'ledger.private.json'))) {
    throw 'No provisioning ledger exists. Verify the actual organizer-provided bundle, not a new unexecuted plan.'
}
Initialize-Zava $BundlePath $MaxSetupSeconds $MaxSetupSeconds
$timer = [Diagnostics.Stopwatch]::StartNew()
$resultPath = Join-Path $BundlePath 'quick-result.private.json'
try {
    Invoke-ZavaPreflight
    if ($Phase -eq 'Apply') { Invoke-ZavaSeed }
    $report = Test-ZavaNative
    $pending = @($report.Creation.Keys | Where-Object {
        $report.Creation[$_] -notin @('EXISTS_READ_BACK', 'INDEX_COUNT_MATCH', 'ACKNOWLEDGED_NOT_READ_BACK')
    })
    $provisioning = if ($pending.Count) { 'PENDING_OR_PROPAGATING' } else { 'SUPPORTED_READBACK_FINISHED' }
    Save-ZavaJson $resultPath @{
        Phase = $Phase
        Provisioning = $provisioning
        PendingCreationChecks = $pending
        LabReadiness = 'NOT_VERIFIED'
        ElapsedSeconds = [Math]::Round($timer.Elapsed.TotalSeconds, 1)
        ManualChecks = $plan.manualOnly
    }
} catch {
    Save-ZavaJson $resultPath @{
        Phase = $Phase
        Provisioning = 'FAILED_OR_INCOMPLETE'
        LabReadiness = 'NOT_VERIFIED'
        ElapsedSeconds = [Math]::Round($timer.Elapsed.TotalSeconds, 1)
        Error = $_.Exception.Message
        Recovery = 'Preserve the ledger; reconcile pending writes/jobs before resuming. Do not create a fresh run to bypass uncertainty.'
    }
    throw
}
Write-Output "Provisioning status: $provisioning. This is NOT a lab-readiness pass."
Write-Output "Review $resultPath and readiness.private.json; perform learner citation, query and connection checks."
Write-Output 'Exit 2 = manual readiness checks remain. Exit 1 = failure. Exit 0 is reserved for offline Plan / opening SignUp.'
exit 2
