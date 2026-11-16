# LAB670 quick context setup

This is a reduced derivative of `Zava-Skillable-Tenant-Setup.zip`, not a new
business dataset. It uses Python's standard library and PowerShell 7.2+.
Python 3.11+ and Azure CLI must already be in the approved lab image.
Nothing installs tools, grants permissions, buys capacity or accepts terms.

Start with the [learner prerequisites](../instructions/lab-setup.md).
Organizers must read the [operator handoff](operator-handoff.md) first.
The learner sequence is GitHub account, then
[GitHub Copilot/Work IQ client setup](../instructions/02-work-iq-setup.md),
then [PowerShell hydration](../instructions/03-context-hydration.md), then
Microsoft IQ playbook curation/testing. Install/authenticate the client first;
defer Zava source checks until hydration is complete.
The supplied Work IQ archive, direct-client JSON and copy-ready prompts are
under `bundles`, `mcp` and `prompts`; the hydration script does not install them
or change client settings.

| Scope | Original full bundle | Quick core |
|---|---|---|
| Work context | 1,650 source files, 3,200 emails, meetings and discussions | 5 original DOCX files + 8 email archive renditions |
| People | 1,000 local persona records | No generated personas or tenant accounts |
| Fabric | 35 tables, 20 models, 5 agent drafts, ontology | 11 original small tables, 3 authoritative models, one seed notebook |
| Foundry/Search | Three large knowledge-base corpora | One MBR knowledge base, five original policy/review passages |
| Business systems | Bulk import payloads | Original Salesforce/Asana snapshots retained offline, not imported |

The three models are `Zava Finance`, `Zava - Commercial` and `Zava Operations`.
The original September 2026 USD figures, historical/current policy conflict,
missing acceptance evidence, and six open/unassigned/undated recovery tasks
are preserved. This core is not the optional seven-scenario enterprise corpus.

## Plan, approve, apply

The organizer supplies a resolved, private `C:\Lab\tenant.quick.json` with the
issued tenant, one existing SharePoint library, existing Fabric workspace and
active capacity, and existing Azure AI Search service. Never put passwords,
tokens, application secrets or the supplied access document in this repository.
The public template intentionally produces a blocked plan.

**New-tenant boundary:** first-time Fabric portal signup removes the onboarding
blocker; it does not create capacity. Capacity/workspace provisioning can be
automated using an approved Azure subscription and permissions, but this reduced
script does not implement that stage. Its `Apply` phase hydrates existing targets.
The desired single-script flow from signup through capacity creation and context
hydration is therefore not yet available here. Have the organizer provision the
targets and supply the resolved configuration before following these commands.

```powershell
# Run in an approved PowerShell 7 terminal from the extracted setup directory.
.\Setup-LabContext.ps1 -Phase SignUp
# Finish browser sign-in, registration and terms yourself before proceeding.
az login --tenant <issued-tenant-guid> --allow-no-subscriptions

.\Setup-LabContext.ps1 -Phase Plan `
  -ConfigPath C:\Lab\tenant.quick.json `
  -BundlePath C:\Lab\ZavaQuick-001

# Read PLAN.md, plan.json, manifest.json and their exact targets/actions/costs.
$hash = (Get-FileHash C:\Lab\ZavaQuick-001\plan.json -Algorithm SHA256).Hash
.\Setup-LabContext.ps1 -Phase Apply `
  -BundlePath C:\Lab\ZavaQuick-001 -ApprovedPlanSha256 $hash
# Type the displayed APPLY phrase only after actual review/approval.
```

`SignUp` only opens `https://app.fabric.microsoft.com` and prints instructions.
It cannot register a tenant, accept terms, determine whether the user finished,
create capacity, or configure ScoringApp. Portal onboarding is a manual gate,
not an API call hidden in the script.

`Plan` is offline. `Apply` checks the approved hashes, authenticates through the
existing Azure CLI session, validates resource bindings, then writes only the
listed resources. A write-ahead private ledger prevents blind write retries.
Existing resources not owned by that ledger and incompatible tables are not
overwritten. Existing names require organizer reconciliation, not renaming
resources to bypass a partial run.

## Timing and exit codes

**5-10 minutes is an unverified warm-environment target, not a measured SLA.**
The Apply/Verify request budget defaults to 600 seconds. Requests and polling
check the shared remaining budget; an in-flight cloud job can outlive it.
Interactive login, Azure CLI token acquisition, browser signup, capacity
creation, M365 indexing and provider propagation are not bounded by this.
One aggregation per table checks row count and required fields in the quick
notebook; the no-overwrite data and post-write checks remain.

| Exit | Meaning |
|---|---|
| 0 | Offline plan generated, or sign-up page opened; no cloud readiness claim |
| 1 | Failed/incomplete; inspect the error and preserve the ledger |
| 2 | Supported checks finished; inspect pending/propagating resources and perform manual lab-readiness checks |

Review `quick-result.private.json` for elapsed time and status, and
`readiness.private.json` for individual readbacks. Search index counts may
still be pending. Run read-only verification against the **same bundle**:

```powershell
.\Setup-LabContext.ps1 -Phase Verify `
  -BundlePath C:\Lab\ZavaQuick-001 -ApprovedPlanSha256 $hash
```

After timeout/failure, reconcile pending writes and job locations before
reapplying the same approved bundle. Do not delete the ledger, submit a second
notebook job or rebuild into a fresh namespace to get around uncertainty.
Run only one process per private bundle. There is no automatic cloud
cleanup/cancellation.

## Validation

```powershell
python -B -m unittest discover -s .\tests -p "test_*.py" -v
pwsh -NoProfile -File .\tests\Test-QuickSetup.ps1
```

These are offline generator/contract and mocked provisioning tests. They do
not establish live Fabric compatibility, query results, OAuth, permission
trimming, Work IQ indexing or an end-to-end ten-minute tenant deployment.
