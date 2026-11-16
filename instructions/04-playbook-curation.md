# Step 4: open Microsoft IQ and curate your playbooks

Complete [Steps 1-3](lab-setup.md) first: GitHub account, Work IQ client setup,
then PowerShell context hydration/source checks.

## 1. Open the lab's Microsoft IQ home page

1. Open the **Microsoft IQ home-page link provided in the lab instructions or
   by the instructor**. Its exact environment URL is pending from the lab
   owner; this page deliberately does not guess a production or preview URL.
2. Sign in with the issued Microsoft lab account and check the assigned
   workspace. Do not use your GitHub credentials here.
3. Locate **Business plugins** or the lab's playbook authoring entry point.
   Choose a learner prefix, such as `Alex`, so your saved items are easy to find.
   A business plugin is the saved reusable guidance/source selection; the
   Work IQ skill you installed in GitHub Copilot is a separate client component.

If the home-page link, workspace or authoring option is unavailable, ask the
instructor. Do not substitute GitHub skill files for a saved Microsoft IQ item.

## 2. Follow the missions and curate the context

1. Open the [mission guide](README.md#your-mission-board). Preserve Mission 1's
   **pre-creation baseline** in a fresh, configured Copilot session before
   creating its business plugin. Use the mission question unchanged.
2. In Microsoft IQ, choose **New/Create**. Enter the mission's name and
   description with your prefix, and select the assigned workspace.
   Leave membership and source permissions unchanged.
3. Add the [common guidance](zava-business-plugins.md#common-guidance-include-in-every-business-plugin)
   and the mission-specific guidance. Keep the question as a test prompt, not
   a saved answer or substitute for reusable guidance.
4. Open **Add context** (label may vary). Search for the mission's actual
   sources, preview their content/metadata, select the relevant references and
   review the selection. Follow each mission's source, date and policy checks.
5. **Save and reopen** the item. Confirm the exact saved name, complete guidance
   and selected sources. Record the actual link/identifier if one is exposed.
6. Return to the configured GitHub Copilot workspace and follow
   [Step 5: test the saved playbook](05-test-playbooks.md). Test after each
   mission's save/reopen, then use the [Copilot judge](zava-copilot-judge.md) in a
   separate fresh session and improve the guidance or source selection.

Use **September 2026, USD and evidence effective by 2026-10-06T18:00:00Z**.
This fictional review is not based on today's date. Keep all output as an
internal draft: do not send messages, assign tasks, modify business records
or publish/deploy agents.

If sources are unavailable, preserve the guidance-only item and record the
gap. Return to curation/testing when access is ready; missing evidence is
not a passing run.

**Next:** [Step 5: test the saved playbook](05-test-playbooks.md), repeated
after each mission's save/reopen step.
