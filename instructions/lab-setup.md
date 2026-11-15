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

**First-time Fabric signup and capacity creation are separate steps.** In the
setup-team test, signing in to the Fabric portal removed the "Tenant wasn't
recognized" error; the tester could then deploy a capacity. Signing in did not
create that capacity. This is portal onboarding, not an instruction to purchase
or assign a paid user license.

The intended new-tenant sequence is:

1. **Learner:** sign in to Fabric and complete the authorized first-time signup.
2. **Approved provisioning automation / organizer:** create the approved capacity
   if needed, create/assign the workspace, and prepare the other source resources.
   If automation uses ScoringApp, its Fabric API access and resource permissions
   must also be configured separately.
3. **Learner or organizer:** run context hydration against those prepared targets.

**Current script limitation:** `Setup-LabContext.ps1` implements signup-page
opening and context hydration, **not step 2**. It requires an existing workspace,
active assigned capacity, SharePoint library and Search service in the private
configuration. On a new tenant, signup alone is therefore **not enough to run
this reduced script**. The intended "sign in, then one script creates capacity
and hydrates context" flow is not implemented in this version.

Do not manually purchase capacity or start a trial to work around that gap.
Capacity creation can be automated, but must use the organizer-approved Azure
subscription, region, SKU, permissions and cost approval. Ask the instructor to
complete that provisioning stage before continuing. Learners should not change
tenant settings, grant organization-wide application consent or authorize
ScoringApp. A trial does not by itself establish the lab's required capacity,
AI features, permissions or source connections.

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

## 3. Configure GitHub Copilot after context hydration

Use this section **after step 2**, before testing the business plugins/playbooks
you create in Microsoft IQ. This configures the **client**, not the tenant
context. Allow separate time for skill setup, sign-in and connection validation.

### Choose the correct client

**You can use GitHub Copilot on the web** when the issued GitHub account has
access to a Copilot **cloud sandbox session**, the Work IQ managed connector,
and project skills in the selected learner workspace. A plain chat with an
attached ZIP is not proof of any of those capabilities.

| Client | Work IQ connection | How the supplied bundle is used |
|---|---|---|
| GitHub Copilot web/cloud sandbox | Connect **Work IQ** through [Copilot Customize](https://github.com/copilot/customize); GitHub manages authentication | Add the bundle's complete skill directory to your learner repository's project skills, review/save it, then start a fresh session |
| Local GitHub Copilot CLI | Use the organizer-supplied HTTP/OAuth configuration below, if supported by the installed client build | Add the same complete skill directory to the approved local lab workspace; restart the client |

Do not paste this direct OAuth configuration into GitHub repository **Settings >
Copilot > MCP servers** and assume it works on the web. GitHub documents that
repository-configured cloud MCP servers do not support remote OAuth servers.
The **managed Work IQ connector is a separate supported route**, not a way to
copy the local callback port into a cloud session. Connectors are preview
features, depend on organization policy, and do not work in GitHub Actions
sessions such as issue-assigned agent runs.

### Get the configuration and Microsoft IQ bundle

1. Use the instructor-approved repository revision. Download/extract the
   repository as in step 2, or give the cloud agent access to the approved
   repository files. A cloud agent cannot open a `C:\...` path on your computer.
2. Locate/download the supplied
   **[MicrosoftIQ-preview.zip](../setup/bundles/MicrosoftIQ-preview.zip)**.
   On its GitHub file page, choose **Download raw file**. This is the original
   supplied archive, distributed without the space before `.zip` in its filename.
   It contains the **`workiq-preview` plugin version 3.1.2**, not a separate
   Fabric/Foundry plugin.
3. Verify its SHA256 if downloading separately:

   ```powershell
   Get-FileHash .\MicrosoftIQ-preview.zip -Algorithm SHA256
   ```

   Expected: `0c151074926e644a95c619f0a181f509bb92754206dd195ee0701a7f9dcca07f`.
4. Locate **[work-iq.json](../setup/mcp/work-iq.json)** and the
   **[copy-ready setup prompt](../setup/prompts/configure-work-iq.txt)**.
   In a local client, reference these files from the extracted lab folder.
   In a cloud session, use their actual repository context/links. If your host
   supports archive attachments, you may attach the ZIP for inspection, but
   uploading it does not install or activate its plugin.

The organizer-supplied **direct-client** configuration is:

```json
{
  "mcpServers": {
    "Work-IQ-MCP": {
      "type": "http",
      "url": "https://workiq.svc.cloud.microsoft/mcp",
      "tools": ["*"],
      "oauthClientId": "ba081686-5d24-4bc6-a0d6-d034ecffed87",
      "oauthPublicClient": true,
      "auth": {
        "redirectPort": 12798
      }
    }
  }
}
```

The OAuth client ID is public configuration, **not** a client secret. Do not
paste credentials/tokens into this JSON or a chat. `tools: ["*"]` exposes all
advertised tools, potentially including writes; it does not authorize their
use. Keep approval controls enabled and restrict this lab to read-only source
operations. Do not enable unattended/all-tools approval.

### Web route: connect Work IQ, then let the agent prepare the skill

1. Sign in to GitHub Copilot with the **issued/approved GitHub account that has
   Copilot access**. This is separate from the Microsoft lab account.
2. Open [Copilot Customize](https://github.com/copilot/customize), find the
   **Work IQ** connector and follow its displayed connection flow. Complete
   Microsoft sign-in yourself with the **issued Skillable Microsoft identity**,
   not your usual work/personal Microsoft account. Stop at unexpected consent
   or policy restrictions and contact the instructor.
3. Open an approved **cloud sandbox session** with a writable learner-owned
   repository/workspace. Do not request setup changes in the shared
   `microsoft/ignite26-LAB670` repository. If Work IQ or a writable skill-enabled
   workspace is unavailable, use the approved local route or ask the instructor;
   do not claim setup succeeded in a text-only chat.
4. Give the agent the approved ZIP and JSON repository files/links above, then
   paste the complete **[setup prompt](../setup/prompts/configure-work-iq.txt)**.
   The prompt asks it to inspect the archive and propose copying only
   `workiq-preview\skills\workiq-preview` to
   `.github\skills\workiq-preview` in your own workspace, preserving references
   and scripts. It must not activate the plugin-root `.mcp.json`, hooks or a
   second server named `workiq-preview`.
5. Review the proposed paths/diff, then approve only those skill-file changes.
   If your cloud host requires repository persistence, save the reviewed change
   in your **own** repository through its review/save flow. The prompt does not
   authorize automatic commits/pushes. Start a **fresh session in that same
   workspace** so the host can discover the new skill.
6. Ask it to confirm that **`workiq-preview` is loaded**, that the actual Work IQ
   connector tools are available, and that a minimal supported read-only source
   check succeeds for the issued Microsoft identity. The managed connector may
   expose a different tool catalog/name from the direct preview server; compare
   actual advertised capabilities. Missing `discover`, `retrieve` or required
   artifact reads are blockers for dependent tests, not permission to invent
   equivalent tools.

### Local route: let the agent merge the direct MCP configuration

1. Open the approved lab workspace in GitHub Copilot CLI. Give it the local
   bundle/config files and paste the same
   **[setup prompt](../setup/prompts/configure-work-iq.txt)**.
2. Review and approve the proposed skill-file changes and the **backup/merge** of
   `Work-IQ-MCP` into `%USERPROFILE%\.copilot\mcp-config.json`, or the configured
   `COPILOT_HOME` directory. Preserve unrelated servers; stop and review any
   same-name/same-endpoint collision. Do not also install the plugin root:
   its bundled MCP entry is named `workiq-preview`, which would duplicate the
   supplied `Work-IQ-MCP` connection.
3. Restart Copilot CLI in the same workspace, then use its supported controls:

   ```text
   /skills
   /mcp
   /mcp auth Work-IQ-MCP
   ```

4. Complete OAuth in the browser yourself using the issued Microsoft account.
   If the installed client rejects the supplied OAuth fields or the approved
   callback port is unavailable, stop and ask the instructor. Do not silently
   drop fields, use a static token in chat, disable policy or switch identities.
5. Verify the loaded skill, actual server tools and a minimal read-only source
   check. File creation alone is not authenticated setup or source readiness.

The setup prompt authorizes **no tenant hydration, business-data writes, WIQD
installation, capacity deployment, grants or organization consent**. The user
retains authentication and approval. It reports installed files, skill loading,
authentication and successful source reads as separate results.

## 4. Check the sources before starting the missions

| Check | Evidence to confirm |
|---|---|
| Work IQ | Find Avery's review request and the review charter through the issued connection; open a source citation. Uploaded email archives are files, not proof of native mailbox ingestion. |
| Fabric IQ | Discover `Zava Finance`, `Zava - Commercial`, `Zava Operations` in the assigned workspace; inspect schema and run a small supported read-only query. |
| Foundry IQ | Use the organizer's actual bound MBR knowledge source; retrieve DOC-03 v2, effective October 1, and inspect its citation. The quick default name is `zava-lab670-mbr-knowledge`; the resource name alone is not an MCP endpoint. |
| Microsoft IQ/GitHub Copilot | Find the existing Microsoft IQ authoring location. In the chosen test client, verify native saved-plugin selection or the exact saved entry's discovery/guidance loading as described below; do not equate the two. |
| Business connectors | For Missions 5-6, verify the instructor's live Salesforce/Asana and other required connections. Local JSON snapshots do not establish native records or access. |

The quick profile retains the authoritative three-model MBR path. It does not
create the multiple **Zava MBR** lookalike/archive reports used by Mission 2's
full discovery exercise, the extra customer/commerce models, or optional
data agents/ontology. With quick-only context, select and inspect the three
models directly; do not claim to have completed report disambiguation.
If required sources are unavailable, record the gap and follow the lab's
guidance-only fallback. Do not invent evidence or report a passing judge score.

## 5. Test each saved business plugin in GitHub Copilot

Continue creating business plugins/playbooks in **Microsoft IQ**, not in the
Work IQ skill bundle. After each mission's **save and reopen** step:

1. Record your exact saved name (including your prefix) and the actual
   link/identifier if Microsoft IQ exposes one.
2. Open a fresh GitHub Copilot session in the same configured learner
   workspace, with the same issued Microsoft identity and source access.
3. Open the **[copy-ready saved-plugin test prompt](../setup/prompts/test-saved-business-plugin.txt)**.
   Replace the three placeholders with the exact saved name, actual link/ID
   (or `unavailable`), and the mission's **unchanged business question**.
   Paste it into the session. Do not paste the mission answer into the prompt.
4. The agent must use the skill's live **`discover`** route when exposed,
   identify the exact saved entry, and retrieve/read the original guidance
   and required companion artifacts before answering. A matching title or
   a discovery summary alone is not loaded context.
5. If that entry is not discoverable from this tenant/host, required artifacts
   cannot be read, or access is denied, record **NEEDS EVIDENCE / NOT VERIFIED**.
   Do not substitute manually pasted guidance and call it a saved-plugin run.
   Use the instructor's original supported Copilot experience if required.
6. Check the returned business draft, opened citations, query/filter evidence
   and missing sources. Record whether the run used **native plugin selection**
   or **discovery-loaded guidance**. The latter does not prove a native
   selection event or any plugin execution mechanism.
7. Preserve Mission 1's pre-creation baseline separately. For comparison/retry,
   keep the mission question, GitHub client, Microsoft identity, tools and
   source access fixed. Use the [Copilot judge](zava-copilot-judge.md) in another
   fresh, equally configured session; the candidate plugin's guidance must
   not become the judge's instructions.

The supplied Work IQ plugin provides workplace retrieval guidance; it does
**not** automatically connect Fabric IQ, Foundry IQ or SaaS tools, publish
Microsoft IQ business plugins, or grant access to sources. Validate those
connections independently for each mission. This lab has not yet verified the
managed connector's preview-tool parity, per-tenant playbook discoverability or
end-to-end GitHub Copilot testing; record real results rather than inferred passes.

## Troubleshooting

| Symptom | Next action |
|---|---|
| "Tenant wasn't recognized by Microsoft Fabric. Sign up ..." | Repeat step 1 with the issued tenant/account and wait for Home. Ask the instructor to check propagation; repeated resource creation is not a signup fix. |
| Fabric API 401/403 | Confirm the tenant/account and resource access. For ScoringApp, the organizer must check the service-principal tenant setting and resource roles separately. Global Administrator alone is not sufficient. |
| No capacity / workspace not assigned / capacity inactive | Ask the organizer to finish capacity preparation. Do not buy or create a substitute. |
| Signup or terms blocked | Stop and involve the instructor. No unattended acceptance or browser-automation workaround is part of this lab. |
| Timeout, pending write or name collision | Keep the same private bundle and ledger. The instructor must reconcile the submitted operation before any retry. |
| Files exist but Work IQ/Foundry cannot retrieve them | Ask the organizer to check indexing, actual connection bindings and learner access; uploads alone are not retrieval readiness. |
| ZIP/JSON was added to chat but no skill/tools are visible | Complete the appropriate client setup above. An attachment is not an installation or authenticated MCP connection. |
| Web session cannot use the supplied OAuth JSON | Use the Work IQ managed connector in an eligible cloud sandbox session, not repository-configured OAuth MCP. Otherwise use the approved local client. |
| `discover` or the exact saved entry is missing | Record the capability/discovery gap and stop the dependent saved-plugin test. Do not invent a binding or silently use pasted guidance. |
| Two Work IQ servers request authentication | Do not install both the plugin-root MCP definition and the separate supplied connection. Ask the instructor to reconcile the duplicate; never remove unrelated settings. |

Report reproducible issues at
[LAB670 issues](https://github.com/microsoft/ignite26-LAB670/issues).
Include the phase, elapsed time, affected mission and redacted error code.
Never upload private configs, credentials, full ledgers, signup form details or
the original access document.

Continue to [Orientation and setup](README.md#orientation-and-setup).

Client references:

- [GitHub Copilot connectors and supported surfaces](https://docs.github.com/en/copilot/concepts/customizations/copilot-connectors)
- [Supported connectors, including Work IQ](https://docs.github.com/en/copilot/reference/supported-connectors)
- [Repository MCP setup and OAuth limitations](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/configure-mcp-servers)
- [Installing skills from an extracted directory](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/customize-cloud-agent/add-skills)
