#Requires -Version 7.2
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$runtime = Join-Path $root 'infra\zava'
$temporary = Join-Path ([IO.Path]::GetTempPath()) ('lab670-quick-' + [guid]::NewGuid().ToString('N'))
$null = New-Item -ItemType Directory -Path $temporary
Import-Module (Join-Path $runtime 'Zava.psm1') -Force

function Assert-Fails([scriptblock]$Action, [string]$Pattern) {
    $caught = $false
    try { & $Action } catch {
        if ($_.Exception.Message -notmatch $Pattern) { throw }
        $caught = $true
    }
    if (-not $caught) { throw "Expected failure matching: $Pattern" }
}

try {
    $config = Read-ZavaJson (Join-Path $root 'tenant.quick.template.json')
    $config.tenantId = '11111111-1111-1111-1111-111111111111'
    $config.tenantDomain = 'lab.example'
    $config.learnerUpn = 'learner@lab.example'
    $config.costApprovalReference = 'OFFLINE-TEST-NO-CLOUD'
    $config.sharePoint.locations[0].siteId = 'mock-site'
    $config.sharePoint.locations[0].driveId = 'mock-drive'
    $config.fabric.workspaceId = '22222222-2222-2222-2222-222222222222'
    $config.fabric.capacityId = '33333333-3333-3333-3333-333333333333'
    $config.search.searchEndpoint = 'https://mock-search.search.windows.net'
    $config.search.searchResourceId = '/subscriptions/44444444-4444-4444-4444-444444444444/resourceGroups/mock-rg/providers/Microsoft.Search/searchServices/mock-search'
    $configPath = Join-Path $temporary 'tenant.json'
    Save-ZavaJson $configPath $config
    $bundle = Join-Path $temporary 'run'
    & pwsh -NoProfile -File (Join-Path $root 'Setup-LabContext.ps1') -Phase Plan -ConfigPath $configPath -BundlePath $bundle
    if ($LASTEXITCODE -ne 0) { throw 'Entrypoint offline Plan failed.' }
    $hash = (Get-FileHash (Join-Path $bundle 'plan.json')).Hash
    Initialize-Zava $bundle 600 600
    Assert-ZavaBundle $hash
    & pwsh -NoProfile -File (Join-Path $root 'Setup-LabContext.ps1') -Phase Apply -BundlePath $bundle -ApprovedPlanSha256 $hash -ApprovalText 'NOT APPROVED' 2>$null
    if ($LASTEXITCODE -ne 1) { throw 'Apply did not reject an incorrect approval phrase with exit 1.' }
    if (Test-Path (Join-Path $bundle 'ledger.private.json')) { throw 'Invalid approval reached live writes.' }
    & pwsh -NoProfile -File (Join-Path $root 'Setup-LabContext.ps1') -Phase Verify -BundlePath $bundle -ApprovedPlanSha256 $hash 2>$null
    if ($LASTEXITCODE -ne 1) { throw 'Verify did not reject a missing ledger with exit 1.' }

    & (Get-Module Zava) {
        $script:MockWrites = [Collections.Generic.List[object]]::new()
        $script:MockObjects = @{}
        $script:MockSearch = @{}
        $script:MockJobState = 'Completed'
        function script:Get-ZavaToken([string]$Audience) { return 'OFFLINE-TEST-TOKEN' }
        function script:Invoke-ZavaRequest([string]$Uri, [string]$Audience, [string]$Method = 'GET', $Body = $null, [byte[]]$Bytes = $null, [hashtable]$ExtraHeaders = @{}) {
            $workspace = $script:Context.Config.fabric.workspaceId
            if ($Method -eq 'GET') {
                if ($Uri -match '/sites/mock-site/drives$') {
                    return @{Status=200; Body=@{value=@(@{id='mock-drive'})}; Headers=@{}}
                }
                if ($Uri.EndsWith("/workspaces/$workspace")) {
                    return @{Status=200; Body=@{capacityId=$script:Context.Config.fabric.capacityId}; Headers=@{}}
                }
                if ($Uri.EndsWith('/capacities')) {
                    return @{Status=200; Body=@{value=@(@{id=$script:Context.Config.fabric.capacityId; state='Active'})}; Headers=@{}}
                }
                if ($Uri.EndsWith('/items') -or $Uri.EndsWith('/jobs/instances')) {
                    return @{Status=200; Body=@{value=@()}; Headers=@{}}
                }
                if ($Uri -match 'management.azure.com') {
                    return @{Status=200; Body=@{name='mock-search'}; Headers=@{}}
                }
                if ($Uri -match '/operations/mock-create/result$') {
                    return @{Status=200; Body=@{id='mock-lakehouse'}; Headers=@{}}
                }
                if ($Uri -match '/operations/mock-create$') {
                    return @{Status=200; Body=@{status='Succeeded'}; Headers=@{}}
                }
                if ($Uri -match '/jobs/instances/mock-job$') {
                    return @{Status=200; Body=@{status=$script:MockJobState}; Headers=@{}}
                }
                if ($Uri -match '/indexes/[^/]+/stats\?') {
                    return @{Status=200; Body=@{documentCount=5}; Headers=@{}}
                }
                if ($Uri -match '/(indexes|knowledgesources|knowledgebases)/([^/?]+)\?') {
                    $key = "$($Matches[1])/$($Matches[2])"
                    if ($script:MockSearch.ContainsKey($key)) {
                        return @{Status=200; Body=$script:MockSearch[$key]; Headers=@{}}
                    }
                    return @{Status=404; Body=@{}; Headers=@{}}
                }
                $id = ([uri]$Uri).Segments[-1].TrimEnd('/')
                if ($script:MockObjects.ContainsKey($id)) {
                    return @{Status=200; Body=$script:MockObjects[$id]; Headers=@{}}
                }
                if ($Uri -match '/root:/') { return @{Status=404; Body=@{}; Headers=@{}} }
                throw "Unhandled mock GET: $Uri"
            }
            $script:MockWrites.Add(@{Uri=$Uri; Method=$Method; Body=$Body})
            if ($Uri.EndsWith('/lakehouses')) {
                if (-not $Body.creationPayload.enableSchemas) { throw 'Schemas were not enabled.' }
                $script:MockObjects['mock-lakehouse'] = @{id='mock-lakehouse'}
                return @{Status=202; Body=@{}; Headers=@{Location=@('https://api.fabric.microsoft.com/v1/operations/mock-create')}}
            }
            if ($Uri -match '/jobs/instances\?') {
                return @{Status=202; Body=@{}; Headers=@{Location=@("https://api.fabric.microsoft.com/v1/workspaces/$workspace/items/mock-notebook/jobs/instances/mock-job")}}
            }
            if ($Uri -match '/docs/index\?') {
                foreach ($doc in $Body.value) {
                    if ($doc.sourcePath -notmatch '^https://mock\.sharepoint\.com/') { throw 'Index citation did not use actual upload URL.' }
                }
                return @{Status=200; Body=@{value=@($Body.value | ForEach-Object { @{key=$_.id; status=$true} })}; Headers=@{}}
            }
            if ($Uri -match '/retrieve\?') {
                return @{Status=200; Body=@{references=@(@{sourceData=@{sourcePath='https://mock.sharepoint.com/DOC-03'}})}; Headers=@{}}
            }
            if ($null -ne $Body -and $Body.ContainsKey('definition')) {
                foreach ($part in $Body.definition.parts) {
                    $text = [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($part.payload))
                    if ($text -match '__[A-Z][A-Z0-9_]+__') { throw 'Unresolved definition binding reached a write.' }
                }
                if ($Body.type -notin @('Notebook','SemanticModel')) { throw 'Unexpected Fabric type.' }
            }
            $id = "mock-created-$($script:MockWrites.Count)"
            $script:MockObjects[$id] = @{
                id=$id
                size=if($null -ne $Bytes){$Bytes.Length}else{0}
                webUrl="https://mock.sharepoint.com/$id"
            }
            if ($Uri -match '/(indexes|knowledgesources|knowledgebases)/([^/?]+)\?') {
                $script:MockSearch["$($Matches[1])/$($Matches[2])"] = $Body
            }
            return @{Status=201; Body=$script:MockObjects[$id]; Headers=@{}}
        }

        Invoke-ZavaPreflight
        Invoke-ZavaSeed
        $first = $script:MockWrites.Count
        Invoke-ZavaSeed
        if ($script:MockWrites.Count -ne $first) { throw 'Resume replayed successful writes.' }
        $report = Test-ZavaNative
        if ($report.KnowledgeBaseRetrieval.Count -ne 1 -or $report.Microsoft365Retrieval -ne 'NOT_RUN') {
            throw 'Service readback was conflated with full source readiness.'
        }
        foreach ($pair in @(@('/items$',4),@('/content\?',13),@('/jobs/instances\?',1),@('/knowledgebases/[^/]+\?',1))) {
            $actual = @($script:MockWrites | Where-Object { $_.Uri -match $pair[0] }).Count
            if ($actual -ne $pair[1]) { throw "Unexpected write count $actual for $($pair[0])" }
        }
        if (@($report.Creation.Values | Where-Object { $_ -eq 'INDEX_COUNT_MATCH' }).Count -ne 1) {
            throw 'Index count was not checked.'
        }
        $afterReadback = $script:MockWrites.Count
        Save-ZavaReceipt 'uncertain/mock' 'PENDING'
        $failed = $false
        try { Invoke-ZavaWrite 'uncertain/mock' 'https://api.fabric.microsoft.com/v1/mock' 'https://api.fabric.microsoft.com' 'POST' @{} } catch {
            if ($_.Exception.Message -notmatch 'Uncertain prior write') { throw }
            $failed = $true
        }
        if (-not $failed -or $script:MockWrites.Count -ne $afterReadback) { throw 'Uncertain write was replayed.' }
        $script:MockJobState = 'Failed'
        $failed = $false
        try { Wait-ZavaOperation 'https://api.fabric.microsoft.com/v1/workspaces/mock/items/mock/jobs/instances/mock-job' } catch {
            if ($_.Exception.Message -notmatch 'ended Failed') { throw }
            $failed = $true
        }
        if (-not $failed) { throw 'Failed job was accepted.' }
        $script:Context.Deadline = [DateTimeOffset]::UtcNow.AddSeconds(-1)
        $failed = $false
        try { Get-ZavaRemainingSeconds } catch {
            if ($_.Exception.Message -notmatch 'time budget exhausted') { throw }
            $failed = $true
        }
        if (-not $failed) { throw 'Expired budget was accepted.' }
        Write-Output "PASS: quick provisioning, LRO/job capture, 13 uploads, 4 item creates, one KB, faithful citation URLs, no-write resume, uncertain-write rejection, failed-job rejection and shared budget. Mock writes: $first; ZERO cloud calls."
    }

    Import-Module (Join-Path $runtime 'Zava.psm1') -Force
    Initialize-Zava $bundle 600 600
    & (Get-Module Zava) {
        function script:az {
            $index = [Array]::IndexOf($args, '--resource')
            $claims = @{tid='55555555-5555-5555-5555-555555555555'; aud=[string]$args[$index+1]; exp=[DateTimeOffset]::UtcNow.AddMinutes(10).ToUnixTimeSeconds()}
            $encoded = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes(($claims | ConvertTo-Json -Compress))).TrimEnd('=').Replace('+','-').Replace('/','_')
            $global:LASTEXITCODE = 0
            return (@{accessToken="header.$encoded.signature"} | ConvertTo-Json -Compress)
        }
        $caught = $false
        try { Get-ZavaToken 'https://graph.microsoft.com' } catch {
            if ($_.Exception.Message -notmatch 'another tenant') { throw }
            $caught = $true
        }
        if (-not $caught) { throw 'Wrong-tenant token was accepted.' }
    }
    Assert-Fails { & (Get-Module Zava) { Assert-ZavaResponse @{Status=400; Body=@{error=@{message="Tenant wasn't recognized by Microsoft Fabric. Sign up for Microsoft Fabric and try again."}}} } } 'not enrolled'
    Assert-Fails { & (Get-Module Zava) { Assert-ZavaResponse @{Status=403; Body=@{}} } } 'ScoringApp'
    Assert-Fails { & (Get-Module Zava) { Invoke-ZavaRequest 'https://unapproved.example/data' 'https://graph.microsoft.com' } } 'unapproved host'
    & (Get-Module Zava) {
        $script:HttpCalls = 0
        function script:Get-ZavaToken([string]$Audience) { return 'OFFLINE-TEST-TOKEN' }
        function script:Invoke-WebRequest {
            $script:HttpCalls++
            return @{StatusCode=429; Content='{}'; Headers=@{'Content-Type'=@('application/json'); 'Retry-After'=@('60')}}
        }
        function script:Start-Sleep([int]$Seconds) {
            if ($Seconds -gt 2) { throw 'Retry sleep exceeded the shared remaining budget.' }
            $script:Context.Deadline = [DateTimeOffset]::UtcNow.AddSeconds(-1)
        }
        $script:Context.Deadline = [DateTimeOffset]::UtcNow.AddSeconds(-1)
        $caught = $false
        try { Invoke-ZavaRequest 'https://graph.microsoft.com/v1.0/me' 'https://graph.microsoft.com' } catch {
            if ($_.Exception.Message -notmatch 'time budget exhausted') { throw }
            $caught = $true
        }
        if (-not $caught -or $script:HttpCalls -ne 0) { throw 'An expired budget reached HTTP.' }
        $script:Context.Deadline = [DateTimeOffset]::UtcNow.AddSeconds(2)
        $caught = $false
        try { Invoke-ZavaRequest 'https://graph.microsoft.com/v1.0/me' 'https://graph.microsoft.com' } catch {
            if ($_.Exception.Message -notmatch 'time budget exhausted') { throw }
            $caught = $true
        }
        if (-not $caught -or $script:HttpCalls -ne 1) { throw 'Throttling ignored the shared budget.' }
        Write-Output 'PASS: request path refuses expired budgets and bounds Retry-After sleeps; ZERO network calls.'
    }
    Add-Content -LiteralPath (Join-Path $bundle 'enterprise\mbr\MAIL-01-email-archive.txt') -Value 'tampered'
    Assert-Fails { Assert-ZavaBundle $hash } 'Bundle file changed'
    Write-Output 'PASS: wrong-tenant token, signup/access diagnostics, host guard and approved-asset tamper rejection.'
} finally {
    $resolved = (Resolve-Path -LiteralPath $temporary).Path
    if ([IO.Path]::GetFileName($resolved) -notmatch '^lab670-quick-[a-f0-9]{32}$') { throw 'Refusing unexpected cleanup target.' }
    Remove-Item -LiteralPath $resolved -Recurse
}
