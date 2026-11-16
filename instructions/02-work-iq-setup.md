# Step 2: add Work IQ to GitHub Copilot

Complete [Step 1](01-github-account.md) first. Configure the client **before**
running the PowerShell hydration bundle. At this stage, confirm the skill and
connection; do not expect Zava evidence or saved playbooks to exist yet.

## 1. Download the Microsoft IQ skill bundle

1. Open [microsofiq-preview.zip](../setup/bundles/microsofiq-preview.zip) and
   choose **Download raw file**. This is the organizer-supplied archive,
   retained byte-for-byte. It contains the `workiq-preview` plugin version
   **3.1.2**, not a separate Fabric/Foundry plugin.
2. Verify its SHA256 in PowerShell:

   ```powershell
   Get-FileHash .\microsofiq-preview.zip -Algorithm SHA256
   ```

   Expected: `537afa1f91a7441868c7a9f8d04db2ce7cc21fece72ee0832a67ab0950131072`.
3. Keep the [full setup prompt](../setup/prompts/configure-work-iq.txt) and
   [direct-client configuration](../setup/mcp/work-iq.json) available as
   instructor-approved repository context or local files. A cloud session
   cannot open a `C:\...` path on your computer.

## 2. Connect Work IQ on the web

1. Open [Copilot Customize](https://github.com/copilot/customize), find
   **Work IQ**, and follow the managed connector's connection flow.
2. Complete Microsoft sign-in yourself using your **issued Skillable Microsoft
   identity**, not your usual work/personal Microsoft account. Stop at
   unexpected consent or policy restrictions and contact the instructor.
   GitHub email verification is not Microsoft authentication.
3. Open an approved **Copilot cloud sandbox session** with a writable
   **learner-owned** repository/workspace and project-skill support. Do not
   install learner files into the shared `microsoft/ignite26-LAB670` repository.
4. If this host supports ZIP attachments, attach the downloaded archive to the
   conversation. Otherwise, provide it as repository context in your own
   workspace. An attachment alone does not install a skill.
5. Give the agent the full setup prompt and configuration file above, then
   paste the installation request below. Review its proposed changes before
   approving only the listed client-file changes.

```text
Help me prepare GitHub Copilot for LAB670 before context hydration.
Use the supplied microsofiq-preview.zip and the full LAB670 setup prompt
at setup/prompts/configure-work-iq.txt from my approved repository revision.
Verify SHA256:
537afa1f91a7441868c7a9f8d04db2ce7cc21fece72ee0832a67ab0950131072

Inspect the archive safely without executing scripts. Propose copying only
microsofiq-preview/skills/workiq-preview, including all references and
scripts, to .github/skills/workiq-preview in this learner-owned workspace.
Preserve existing skills and ask for approval before writing or replacing.
Do not install the plugin-root MCP definition, hooks or a duplicate server.
On the web, use the managed Work IQ connector; I will complete sign-in.
Do not install the direct OAuth JSON in repository cloud MCP settings.
If this host cannot install/load project skills or expose Work IQ tools,
stop and report the limitation instead of claiming the ZIP is installed.

After approval, make only the reviewed client-file changes, read them back,
and tell me when to save them in my own workspace and start a fresh session.
Do not commit/push, run hydration, install WIQD, execute bundled scripts,
grant permissions or create cloud resources. Verify skill loading, actual
tools and authentication separately. Zava source checks and saved-playbook
testing are deferred until hydration and playbook creation are complete.
```

6. Review and save the skill files in your own workspace through the host's
   review/save flow, then start a **fresh session in that same workspace**.
   The prompt does not authorize automatic commits/pushes.
7. Paste this connection checkpoint prompt:

   ```text
   Confirm that workiq-preview is loaded and list the actual advertised
   Work IQ tool names/capabilities. Confirm whether the connector is
   authenticated with my issued Microsoft lab account using only a
   supported minimal read-only check, if one is available. Do not perform
   broad mailbox searches or query Zava yet. Report skill loading, tool
   availability and authentication separately; mark anything not verified.
   Do not invent tools or treat installed files as authenticated access.
   ```

Managed connectors are preview features and depend on account/organization
policy. They do not work in GitHub Actions sessions such as issue-assigned agent
runs. A plain text-only chat is not necessarily a skill-enabled cloud sandbox.
If the required capabilities are unavailable, ask the instructor to approve the
local route below; do not mark web installation as passed.

## Local alternative: direct Work IQ configuration

Use this route only when instructed. The exact organizer-supplied configuration
is also in [work-iq.json](../setup/mcp/work-iq.json):

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

1. Open the approved learner workspace in GitHub Copilot CLI. Supply the ZIP,
   JSON and full setup prompt. Review the proposed skill installation and
   backup/merge into `%USERPROFILE%\.copilot\mcp-config.json`, or the configured
   `COPILOT_HOME` directory. Preserve unrelated servers; stop at any
   same-name/same-endpoint collision.
2. Approve only the reviewed client files. Copy the complete skill directory,
   not the plugin root: its `.mcp.json` adds a server named `workiq-preview`
   and would duplicate the supplied `Work-IQ-MCP` connection.
3. Restart the CLI in the same workspace, then use:

   ```text
   /skills
   /mcp
   /mcp auth Work-IQ-MCP
   ```

4. Complete OAuth yourself with the issued Microsoft identity. If the installed
   client rejects the supplied OAuth fields or the approved callback port is
   unavailable, stop and ask the instructor. Do not drop fields, use static
   tokens in chat or disable policy.
5. Run the same connection checkpoint above. Resolve actual tool names/schemas
   from the live catalog, not server-name guesses.

Do not paste this direct OAuth JSON into GitHub repository **Settings > Copilot >
MCP servers** and assume it works on the web: repository-configured cloud MCP
does not support remote OAuth. The managed connector is a separate route.
The OAuth client ID is public configuration, not a secret. `tools: ["*"]`
exposes potentially mutating tools but does not authorize their use. Keep
approval controls enabled; no unattended all-tools approval, tenant writes,
WIQD installation, capacity deployment or organization consent is authorized.

**Checkpoint:** skill files, skill loading, tools and authentication are
reported separately. No Zava retrieval or saved-playbook test is claimed.

**Next:** [Step 3: run the PowerShell context setup](03-context-hydration.md).

References:

- [Copilot connectors and supported surfaces](https://docs.github.com/en/copilot/concepts/customizations/copilot-connectors)
- [Supported connectors, including Work IQ](https://docs.github.com/en/copilot/reference/supported-connectors)
- [Repository MCP setup and OAuth limitations](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/configure-mcp-servers)
- [Project skills](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/customize-cloud-agent/add-skills)
