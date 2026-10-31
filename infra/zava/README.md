# Zava setup: Microsoft test and Skillable environments

Read [the all-IQ scenarios](../../instructions/zava-scenarios.md) and
[business-process reference candidates](../../instructions/zava-business-playbooks.md)
first. This optional setup leaves Alpine Retail S01-S05 unchanged.

**Implemented and locally exercised:** public source download, fixture/corpus
generation, artifact definitions, approval/tenant guards and mocked provisioning.
**NOT_RUN:** live Microsoft/Skillable provisioning, native source access, MSIT candidate
creation/curation and end-to-end consumption. Local tests are not tenant evidence.

## One implementation, two responsibilities

[Zava Enterprise Context](https://github.com/santhoshravindran7/zava-enterprise-context)
is the neutral, public source/setup repository. LAB670 owns the learner journey,
product instructions and actual redacted screenshots. The lab delegates setup
to the public implementation rather than copying its runtime.

The wrapper pins commit
`f49fee49b77dd1b4c19e7be0aba89c6ce4a2a330` and archive SHA256
`53025ed29c2cc5314b59fce88cca864328251364ef8f4ed62995ce77100a703d`.
It verifies the archive and every extracted source byte before executing it.
An archive-generation change fails closed and requires a reviewed checksum/pin
update; never bypass the check or silently follow `main`.

## Generated inventory

| Context | Inventory | Native distinction |
|---|---|---|
| Work | 105 Word documents, 128 unsent email archives, 60 transcript archives; 581 SharePoint-ready files | Archives are not received Outlook mail or native Teams transcripts |
| People | Eight fictional personas | Optional disabled Entra users; no license, mailbox or grants |
| Web | Forty synthetic HTML pages and two original market bulletins | Actual HTTPS publication/admission is manual |
| Fabric | Eleven tables, one seed notebook, twenty model definitions, three agent drafts and one six-entity ontology | Query, publication, graph refresh/traversal require native checks |
| Knowledge | Three indexes, three knowledge sources and three actual knowledge-base creation payloads | Existing Azure AI Search service; extractive retrieval, not a Foundry-agent trace |
| SaaS | Salesforce/Asana snapshots and forty ServiceNow incidents | Native sandbox imports/consent/readback are manual |

Alternate formats and seventeen additional analytical perspectives are copies/
views over the same facts, not independent corroboration. The public pack is a
neutral adaptation of the Zava sources with its **own** byte-bound manifest;
do not mix fixture hashes or native bindings across environments.

## Local Plan: no tenant login or writes

Prerequisites: PowerShell 7.2+, Python 3.11+, internet access to the approved
public source. The corpus generator uses only Python's standard library.

```powershell
pwsh -NoProfile -File .\infra\zava\Setup-Lab670.ps1 `
  -Phase Plan -Bundle C:\LabPrivate\zava-plan-001
```

Use new output directories outside the repository. The source cache defaults
to `C:\LabPrivate\zava-plan-001-source`. Plan creates the full context locally,
the resource/action plan and a standalone source ZIP. Unknown targets produce
`DRAFT_UNBOUND`, not a success-shaped native result.

## Resolve the issued Skillable environment

Copy the pinned source's `infra\zava\environment.template.json` to a private
location. Obtain the actual running-instance tenant GUID/domain, existing
approved SharePoint site/library, active Fabric capacity/workspace, existing
Search ARM ID/endpoint, feature admission and incremental cost approval.

Profile **225730** and resource-group record **42283** are Skillable record
numbers, not Entra/Azure resource IDs. A stopped profile, `Deny All*`, no listed
resources and a removed F2 capacity are not verified prerequisites. Displayed
expected cost `$0.00` does not authorize Fabric/Search consumption. Do not
change policy, restore capacity or grant licenses as part of this wrapper.

Generate a new bound Plan:

```powershell
pwsh -NoProfile -File .\infra\zava\Setup-Lab670.ps1 -Phase Plan `
  -Config C:\LabPrivate\skillable.json -Bundle C:\LabPrivate\zava-bound-001
```

Review its entire plan/manifests, exact targets, optional account/mail/calendar
rows, existing privileges and costs. Obtain explicit human approval. Source
download/hash checks, configuration fields and typed phrases are not consent.

## Approved native execution

The user handles login, credentials and consent to the issued tenant. Azure
CLI is required for live phases; it is not automatically installed or invoked
for login.

```powershell
az login --tenant <SKILLABLE-TENANT-GUID> --allow-no-subscriptions
$bundle = 'C:\LabPrivate\zava-bound-001'
$hash = (Get-FileHash (Join-Path $bundle 'plan.json')).Hash.ToLowerInvariant()
pwsh -NoProfile -File .\infra\zava\Setup-Lab670.ps1 -Phase Apply `
  -Bundle $bundle -TenantId <SKILLABLE-TENANT-GUID> `
  -ApprovedPlanSha256 $hash
```

The explicit tenant GUID must match the approved bundle configuration.
`-SkillableTenantId` remains an alias for existing Skillable commands. The
public adapter also verifies token tenant/audience, verified domain, site/
library, workspace/capacity and Search resource/endpoint before source writes.
MSIT playbook authoring is a separate environment/action plan and does not
authorize MSIT source provisioning.

## Microsoft/MSIT test before Skillable rehearsal

A separately approved Microsoft tenant can host the first source-provisioning
test. Use a private Microsoft-test configuration and new plan/ledger/cache
directories, then pass its exact approved GUID as `-TenantId`. Do not call a
Microsoft GUID Skillable-issued, mix source IDs between tenants, or treat
Microsoft success as Skillable validation.

For a new test SharePoint site, first use the pinned public source's
`infra\zava\Setup-SharePointSite.ps1` with a separate site-only Plan/Apply/Verify
approval. It creates one communication site, no group/team or added members,
reads site/library access, and returns native site/library IDs privately.
Tenant policies and administrator access remain applicable. It never uploads
the enterprise corpus. Copy the verified IDs into the Microsoft-test content
configuration, generate a new bound content plan and obtain its separate
approval before running this wrapper. The site's hash cannot authorize seeding.

Existing active Fabric capacity/workspace and Search service, preview admission,
licenses and incremental cost approval are still required; no service purchase
or permission grant is automatic. Obtain Microsoft's tenant/site policy
approval rather than trying to bypass denied self-service creation or API access.

After admitted source reads, curate the MSIT candidates and capture their
saved/reopened guidance and source references. Current authoring is blocked:
the available UI actions did not open the creation dialog, and the latest
computer-use check reports a locked/disconnected Windows session. The operator
must unlock/reconnect the session; scripts must not bypass that desktop gate.
No candidate save,
source attachment or creation screenshot has been verified. This is an
automation limitation, not a confirmed product defect.

For Verify, use the same arguments with `-Phase Verify`. Retain actual private
resource/file-size/job/index-count and knowledge-base retrieval evidence.
Then independently check Work IQ access, DAX, data-agent publication/query,
ontology refresh/traversal, Foundry client, Web IQ and SaaS source reads.

No sends, invitations, grants, account enablement, paid-service creation,
capacity changes or deletion occur automatically. Optional drafts/appointments
are recipient/attendee-free and do not create native Teams history.

## Tests and release gate

Run the public repository's Python and PowerShell checks from the pinned source:

```powershell
python -B -m unittest discover -s .\infra\zava\tests -v
pwsh -NoProfile -File .\infra\zava\tests\Test-Safety.ps1
pwsh -NoProfile -File .\infra\zava\tests\Test-Provisioning.ps1
pwsh -NoProfile -File .\infra\zava\tests\Test-SharePointSite.ps1
```

From the lab repository, run
`pwsh -NoProfile -File .\infra\zava\tests\Test-TenantBinding.ps1`
for the wrapper's generic tenant binding and legacy-alias guards.

Those tests are the reusable **setup regression suite**, not proof that Skillable
has been provisioned. Admit the lab only after the actual tenant run, native
source reads and fresh learner/custom-harness consumption pass independently.
The 10-20 minute warm-setup target is unverified and can be exceeded by startup,
hundreds of API calls, licensing/indexing and preview admission.

See the public [operator guide](https://github.com/santhoshravindran7/zava-enterprise-context/blob/f49fee49b77dd1b4c19e7be0aba89c6ce4a2a330/docs/operations.md)
for exact manual alternatives, recovery, privilege intent and private evidence.
