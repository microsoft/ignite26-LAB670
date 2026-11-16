# Step 3: run the PowerShell context setup

Complete [GitHub account setup](01-github-account.md) and
[Work IQ client setup](02-work-iq-setup.md) first. Run the reviewed script
yourself in the lab VM, **not through a Copilot prompt**.

The 5-10-minute hydration target applies only to prepared resources and is
**not a measured SLA**. Signup, authentication, capacity provisioning, indexing
and permission propagation may take longer.

## 1. Sign in to Fabric

1. Open [fabric.microsoft.com](https://fabric.microsoft.com), or use
   [app.fabric.microsoft.com](https://app.fabric.microsoft.com).
2. Sign in with the Microsoft username/password issued by Skillable, not your
   GitHub account or normal work/personal account.
3. Complete any first-time signup form with organizer-provided details.
   Review/accept terms yourself only if authorized. Ask the instructor if
   required organization details or approval are missing.
4. Wait for Fabric Home. Check the tenant/account in your profile and open the
   assigned existing workspace using the lab-provided link.

**Signup is not capacity creation.** The setup-team test showed that signing
in removed the "Tenant wasn't recognized" blocker and then capacity deployment
could proceed. It did not create capacity or imply a paid user license purchase.

The approved provisioning automation/organizer must prepare the capacity and
workspace, plus SharePoint and Search targets. If provisioning uses ScoringApp,
its Fabric API access and resource roles are separate prerequisites.
**The current reduced script does not create capacity or workspace.**
Its intended single-script new-tenant provisioning stage remains unimplemented.
Do not buy capacity, start a trial, change tenant settings, grant organization
consent or authorize ScoringApp to work around that gap. Ask the instructor to
complete the approved provisioning stage.

## 2. Download and prepare the complete setup bundle

**If the lab is prehydrated:** do not create another copy. Use the provided
sources and go to [source checks](#4-check-source-readiness).

Otherwise, proceed only when the instructor asks you to hydrate your isolated
tenant:

1. Download the **[complete organizer-provided setup bundle](https://1drv.ms/u/c/014eee29eb05bb56/IQBE2dpNyACASKH3fMUxGJxbATWC6ROgyu9sGpEWaJ4_s0c?e=cFwHyq)**,
   or use the prepared copy on the VM. Confirm the download contains
   `setup\Setup-LabContext.ps1`, `setup\infra` and `setup\data`; do not run a
   skills-only archive as tenant setup. If sharing is blocked, ask the instructor.
   The repository's **Code > Download ZIP** is an alternative
   when that revision is approved. Extract All before running anything.
   `Setup-LabContext.ps1` alone is not sufficient: keep its `infra`, `data` and
   other supplied dependencies. The Microsoft IQ skill ZIP from Step 2 is a
   different bundle; it does not hydrate the tenant.
2. Open **PowerShell 7.2+**, not Windows PowerShell 5.1. Python 3.11+ and Azure
   CLI must already be installed in the approved image. Change to the extracted
   `setup` directory. Stop if execution policy blocks the script; no administrator
   terminal or execution-policy bypass is required by these instructions.
3. Obtain the instructor-supplied private `C:\Lab\tenant.quick.json` with your
   tenant and existing SharePoint library, Fabric workspace/active capacity and
   Search service. The public template is intentionally incomplete. Do not
   guess IDs, grant permissions or put this configuration in Copilot or GitHub.
4. Sign in using the issued tenant GUID:

   ```powershell
   $tenantId = Read-Host 'Enter your issued lab tenant GUID'
   az login --tenant $tenantId --allow-no-subscriptions
   ```

The optional `.\Setup-LabContext.ps1 -Phase SignUp` opens the Fabric signup page;
it does not fill the form, accept terms or verify completion.

## 3. Plan, review, apply and verify

1. Generate an offline plan. The output directory must be **new** and outside
   the extracted repository:

   ```powershell
   .\Setup-LabContext.ps1 -Phase Plan `
     -ConfigPath C:\Lab\tenant.quick.json `
     -BundlePath C:\Lab\ZavaQuick-001
   ```

2. Review `PLAN.md`, `plan.json`, `manifest.json`, exact targets, actions and
   approved costs with the instructor. Stop if the plan says `DRAFT_UNBOUND`
   or lists blockers. After review:

   ```powershell
   $hash = (Get-FileHash C:\Lab\ZavaQuick-001\plan.json -Algorithm SHA256).Hash
   .\Setup-LabContext.ps1 -Phase Apply `
     -BundlePath C:\Lab\ZavaQuick-001 -ApprovedPlanSha256 $hash
   ```

3. Type the displayed approval phrase only after approval. The script creates
   five source documents/eight email archive renditions, eleven small Fabric
   tables, three core models, a seed notebook and one five-passage MBR knowledge
   base. It does not create accounts, native mailbox/Teams history, SaaS records
   or source connections.
4. Inspect `quick-result.private.json` and `readiness.private.json`. Exit `1`
   means failure/incomplete. Exit `2` means inspect supported readbacks and
   perform manual checks, **not a lab pass**. Exit `0` is for offline Plan or
   opening the signup page, not live readiness.
5. Run read-only verification against the **same** bundle:

   ```powershell
   .\Setup-LabContext.ps1 -Phase Verify `
     -BundlePath C:\Lab\ZavaQuick-001 -ApprovedPlanSha256 $hash
   ```

After timeout/failure, preserve the private bundle and ledger. Ask the instructor
to reconcile pending writes/jobs before any retry. Do not create a new namespace,
delete the ledger or submit duplicate jobs to bypass uncertainty. Only one
process may use the bundle at a time; submitted cloud jobs may outlive the budget.

## 4. Check source readiness

Now return to the configured client. Source retrieval checks happen **after**
hydration, not during the initial Work IQ installation.

| Source | Evidence to confirm |
|---|---|
| Work IQ | Find Avery's review request and the review charter through the issued connection; open a source citation. Uploaded email archives are files, not proof of native mailbox ingestion. |
| Fabric IQ | Discover `Zava Finance`, `Zava - Commercial`, `Zava Operations`; inspect schema and run a small supported read-only query in the assigned workspace. |
| Foundry IQ | Retrieve DOC-03 v2, effective October 1, through the organizer's actual bound MBR source and inspect its citation. The default name `zava-lab670-mbr-knowledge` is not itself an MCP endpoint. |
| Business connectors | For Missions 5-6, verify the live Salesforce/Asana and other required connections. Local snapshots do not establish native records/access. |

Quick context omits the duplicate/archive **Zava MBR** reports, optional
customer/commerce models, data agents and ontology. Inspect the three models
directly; do not claim report-disambiguation completion. Work IQ installation
does not establish Fabric, Foundry or SaaS access. Record missing sources as
gaps; never invent evidence or report a passing judge score.

See the [technical setup reference](../setup/README.md) for runtime details and
the [organizer handoff](../setup/operator-handoff.md) for provisioning duties.

**Next:** [Step 4: open Microsoft IQ and curate playbooks](04-playbook-curation.md).
