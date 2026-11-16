# Step 5: test each saved playbook in GitHub Copilot

Use this page **after** [playbook curation and save/reopen](04-playbook-curation.md).
The GitHub account and Work IQ client were configured in Steps 1-2, before
PowerShell hydration. Do not reinstall them for each playbook.

## Run the saved-playbook test

1. Record your exact saved business plugin/playbook name, including your prefix,
   and its actual link/identifier if Microsoft IQ exposes one.
2. Open a fresh GitHub Copilot session in the same configured learner-owned
   workspace with the same issued Microsoft identity and source access.
3. Open the [copy-ready saved-plugin test prompt](../setup/prompts/test-saved-business-plugin.txt).
   Replace its three placeholders with the exact saved name, actual link/ID
   (or `unavailable`), and the mission's unchanged business question.
   Paste it into the session. Do not paste the mission answer.
4. The agent must use the skill's live `discover` route when exposed, identify
   the exact saved entry, verify identity/scope/version, and retrieve/read the
   original guidance and required companion artifacts **before** dependent
   queries or drafting. A matching title or discovery summary is not loaded
   guidance.
5. If discovery is unavailable, the exact entry is absent/ambiguous, required
   artifacts cannot be read or access is denied, stop the dependent test and
   record **NEEDS EVIDENCE / NOT VERIFIED**. Do not silently substitute manually
   pasted guidance, another plugin/account or an invented endpoint. Use the
   instructor's original supported Copilot experience if required.
6. Check the business draft, opened citations, query/filter evidence and missing
   sources. Record whether the run used **native plugin selection** or
   **discovery-loaded guidance**. The latter does not prove a native selection
   event or any plugin execution mechanism.
7. Preserve Mission 1's pre-creation baseline separately. Keep the mission
   question, client, identity, tools and source access fixed for comparisons.
   Use the [Copilot judge](zava-copilot-judge.md) in another fresh, equally
   configured session; the candidate plugin's guidance must not become the
   judge's instructions.

## Example: the Mission 1 Zava question

In the full saved-plugin test prompt, supply your exact saved playbook name and
link/ID, then replace the mission-question placeholder with:

```text
What does Avery need for Zava's September 2026 review? Prepare an internal
brief with the business question, recorded decisions, conflicting opinions,
open evidence questions and reviewer roles. Cite the workplace sources.
Do not send messages, assign work or treat email commentary as financial proof.
```

For other missions, use their own unchanged question, not this example.
The installed Work IQ skill enables the retrieval workflow; it does not contain
your tenant's Zava evidence or replace the playbook saved in Microsoft IQ.

Work IQ alone does not connect Fabric IQ, Foundry IQ or SaaS tools, publish
business plugins or grant source access. Validate those bindings independently.
The lab has not yet verified end-to-end installation, managed-connector preview
tool parity or per-tenant playbook discoverability; record real results rather
than inferred passes.

## Troubleshooting and feedback

| Symptom | Next action |
|---|---|
| ZIP attached but no skill/tools | Complete [Step 2](02-work-iq-setup.md); attaching a file is not installation or authentication. |
| Web session cannot use direct OAuth JSON | Use the managed Work IQ connector in an eligible cloud sandbox, or the approved local route. |
| Two Work IQ servers request authentication | Do not activate both the plugin-root MCP definition and separate connection; ask the instructor to reconcile duplicates. |
| `discover` or exact saved entry missing | Record the gap and stop the dependent test; do not substitute pasted guidance. |
| Sources uploaded but not retrievable | Ask the organizer to check indexing, bindings and learner access; uploads alone are not readiness. |

Report reproducible issues at [LAB670 issues](https://github.com/microsoft/ignite26-LAB670/issues).
Include the phase, elapsed time, affected mission and redacted error code.
Never upload credentials, verification codes, private configurations, ledgers
or the original access document.

Return to the [mission guide](README.md#your-mission-board) for the next mission.
