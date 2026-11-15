# Prerequisites: sign in and prepare the Zava context

Complete this section **before Mission 1**. Allow **5-10 minutes only when the
organizer's resources and source connections are already prepared**. First-time
signup, capacity provisioning, indexing or permission propagation may take longer.
Do not spend the mission time debugging tenant administration; ask the instructor.

## 1. Open Fabric with your issued lab identity

1. In the lab VM, open `https://fabric.microsoft.com`. If needed, use the direct
   application address: [https://app.fabric.microsoft.com](https://app.fabric.microsoft.com).
2. Select **Sign in** and use the username/password shown by Skillable.
   Do not use your personal account, normal work account or GitHub account.
3. If this is the account's first visit, complete the displayed Fabric signup
   form using the issued lab account and organizer-provided details. The fields
   and prompts may vary. Review and accept any terms yourself only if authorized.
   If required organization details or approval are missing, ask the instructor.
4. Wait until **Fabric Home** opens. Check the account and tenant in the profile
   menu. Open the **assigned existing workspace** using the lab-provided link.
5. If the portal already opens normally, no second signup is needed. Signing in
   enrolls the user/tenant experience; it does **not** create an Azure F capacity,
   assign a workspace to capacity, or enable service-principal API permissions.

Do **not** create a paid capacity, start a trial, change tenant settings, consent
for an organization or grant ScoringApp permissions. Those are organizer tasks.
A Fabric trial is not a guaranteed substitute for the lab's configured capacity
and AI features.

From the extracted `setup` directory, the optional command below opens the
same signup page; it does not fill or submit the form:

```powershell
.\Setup-LabContext.ps1 -Phase SignUp
```

## 2. Use the organizer's prepared context or run the approved quick setup

**If the lab is prehydrated:** do not create another copy. Use the supplied
workspace/source links and continue to step 3. If the instructor provides an
existing private setup bundle, they can run its read-only `Verify` phase.

**If the instructor explicitly asks you to hydrate your isolated tenant:**

1. Download the organizer-approved copy of this repository, or use the copy
   already on the lab VM. On GitHub, choose **Code > Download ZIP**, then
   **Extract All**. Use the release/ref specified by the instructor, not an
   arbitrary newer revision. Do not run scripts directly from a ZIP viewer.
2. Open **PowerShell 7** (not Windows PowerShell 5.1) and change to the extracted
   `setup` directory. Python 3.11+ and Azure CLI must already be installed.
   No administrator terminal or execution-policy bypass is required by this guide;
   stop if the lab's policy blocks script execution.
3. Obtain the instructor-supplied private `C:\Lab\tenant.quick.json`. It must
   identify your issued tenant and **existing** approved SharePoint library,
   Fabric workspace/capacity and Search service. Do not guess resource IDs or
   edit permissions to make the script work. The public template is not ready to apply.
4. After completing Fabric signup, sign in to Azure CLI when prompted by this
   command, using the same issued lab identity. Replace the placeholder with
   the tenant GUID supplied by the instructor:

   ```powershell
   az login --tenant <issued-tenant-guid> --allow-no-subscriptions
   ```

5. Generate a local, offline plan. The output path must be new and outside the
   extracted repository:

   ```powershell
   .\Setup-LabContext.ps1 -Phase Plan `
     -ConfigPath C:\Lab\tenant.quick.json `
     -BundlePath C:\Lab\ZavaQuick-001
   ```

6. Review `C:\Lab\ZavaQuick-001\PLAN.md` and `plan.json` with the instructor.
   Check the tenant, target resources, writes and approved usage costs. Do not
   proceed if the plan says `DRAFT_UNBOUND` or lists blockers.

   ```powershell
   $hash = (Get-FileHash C:\Lab\ZavaQuick-001\plan.json -Algorithm SHA256).Hash
   .\Setup-LabContext.ps1 -Phase Apply `
     -BundlePath C:\Lab\ZavaQuick-001 -ApprovedPlanSha256 $hash
   ```

7. Type the displayed approval phrase only after that review. The script creates
   five source documents/eight email archive renditions, eleven small Fabric
   tables, three core models and one five-passage MBR knowledge base. It does not
   create accounts, native mailbox/Teams history, SaaS records or source connections.
8. Inspect `quick-result.private.json` and `readiness.private.json`. Exit `2`
   means manual source checks still remain, **not** a lab pass. Exit `1` means
   failure/incomplete setup. Preserve the private ledger after any timeout;
   ask the instructor before resuming.

### Why not ask GitHub Copilot to generate the context?

Use the reviewed PowerShell entrypoint as the primary route. It preserves exact
business values, policy versions and missing fields, records elapsed time, and
does not depend on generated code or an agent choosing what to deploy.
You do not need to open a Copilot session or paste a provisioning prompt.
Copilot may explain an error, but do not give it passwords, tokens, the private
access document or permission to improvise extra resources.

## 3. Check the sources before starting the missions

| Check | Evidence to confirm |
|---|---|
| Work IQ | Find Avery's review request and the review charter through the issued connection; open a source citation. Uploaded email archives are files, not proof of native mailbox ingestion. |
| Fabric IQ | Discover `Zava Finance`, `Zava - Commercial`, `Zava Operations` in the assigned workspace; inspect schema and run a small supported read-only query. |
| Foundry IQ | Use the organizer's actual bound MBR knowledge source; retrieve DOC-03 v2, effective October 1, and inspect its citation. The quick default name is `zava-lab670-mbr-knowledge`; the resource name alone is not an MCP endpoint. |
| Microsoft IQ/Copilot | Open the supplied entry links, find the existing authoring location and confirm that a saved business plugin can be selected in Copilot. |
| Business connectors | For Missions 5-6, verify the instructor's live Salesforce/Asana and other required connections. Local JSON snapshots do not establish native records or access. |

The quick profile retains the authoritative three-model MBR path. It does not
create the multiple **Zava MBR** lookalike/archive reports used by Mission 2's
full discovery exercise, the extra customer/commerce models, or optional
data agents/ontology. With quick-only context, select and inspect the three
models directly; do not claim to have completed report disambiguation.
If required sources are unavailable, record the gap and follow the lab's
guidance-only fallback. Do not invent evidence or report a passing judge score.

## Troubleshooting

| Symptom | Next action |
|---|---|
| "Tenant wasn't recognized by Microsoft Fabric. Sign up ..." | Repeat step 1 with the issued tenant/account and wait for Home. Ask the instructor to check propagation; repeated resource creation is not a signup fix. |
| Fabric API 401/403 | Confirm the tenant/account and resource access. For ScoringApp, the organizer must check the service-principal tenant setting and resource roles separately. Global Administrator alone is not sufficient. |
| No capacity / workspace not assigned / capacity inactive | Ask the organizer to finish capacity preparation. Do not buy or create a substitute. |
| Signup or terms blocked | Stop and involve the instructor. No unattended acceptance or browser-automation workaround is part of this lab. |
| Timeout, pending write or name collision | Keep the same private bundle and ledger. The instructor must reconcile the submitted operation before any retry. |
| Files exist but Work IQ/Foundry cannot retrieve them | Ask the organizer to check indexing, actual connection bindings and learner access; uploads alone are not retrieval readiness. |

Report reproducible issues at
[LAB670 issues](https://github.com/microsoft/ignite26-LAB670/issues).
Include the phase, elapsed time, affected mission and redacted error code.
Never upload private configs, credentials, full ledgers, signup form details or
the original access document.

Continue to [Orientation and setup](README.md#orientation-and-setup).
