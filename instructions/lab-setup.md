# LAB670 setup: follow these pages in order

The learner flow is **GitHub account -> Work IQ in GitHub Copilot ->
PowerShell context hydration -> Microsoft IQ playbook curation -> saved-playbook
testing**. Configure the client before hydration; retrieve Zava evidence only
after sources are ready, and test saved playbooks only after save/reopen.

## Markdown files to load in the lab

Load the following individual Markdown files in this order. This page is the
navigation/index page, not an additional setup exercise.

| Order | Markdown file | Learner action |
|---|---|---|
| 1 | [01-github-account.md](01-github-account.md) | Sign up/sign in, create a unique password and verify the email through Outlook. |
| 2 | [02-work-iq-setup.md](02-work-iq-setup.md) | Install/authenticate Work IQ, then inspect and add approved additional Microsoft IQ skills using the supplied download and copy-ready prompts. |
| 3 | [03-context-hydration.md](03-context-hydration.md) | Complete Fabric onboarding, run the reviewed PowerShell bundle if needed, and check source readiness. |
| 4 | [04-playbook-curation.md](04-playbook-curation.md) | Open [Microsoft IQ](https://aka.ms/AA146gyq), follow the mission guide and curate/save/reopen playbooks. |
| 5 | [05-test-playbooks.md](05-test-playbooks.md) | Load the exact saved playbook in the configured client, ask the unchanged mission question and inspect citations. Repeat after each mission's save/reopen. |

Keep the [mission guide](README.md) and [business-plugin curation reference](zava-business-plugins.md)
available during pages 4-5. The mission guide contains the original questions,
source-selection checks and mission-specific guidance; the numbered pages do
not replace it. Use the lab's [Microsoft IQ home-page link](https://aka.ms/AA146gyq)
to begin authoring.

## Before you start

- Use an instructor-approved GitHub identity for GitHub, and the issued
  **Skillable Microsoft identity** for Outlook, Work IQ, Fabric and Microsoft IQ.
  Never paste passwords or verification codes into Copilot.
- GitHub account creation does not guarantee access to a Copilot cloud sandbox,
  project skills or the managed Work IQ connector. Ask the instructor to confirm
  those capabilities; do not buy a plan to bypass a restriction.
- The Microsoft IQ skill ZIP is **not** the PowerShell hydration bundle.
  Attaching either ZIP does not install it or authorize running its scripts.
  The supplied OneDrive URLs for setup and additional skills are identical;
  verify the contents for each purpose rather than assuming two separate files.
- The reduced PowerShell script requires existing approved Fabric capacity/
  workspace, SharePoint library and Search service plus a private configuration.
  It does **not** create capacity. New-tenant infrastructure provisioning
  remains an organizer prerequisite, not a hidden learner step.
- The 5-10-minute hydration target is unverified and applies only to prepared
  resources. Account creation, client authentication, signup, provisioning,
  indexing and propagation take separate time.

## 5. Test each saved business plugin in GitHub Copilot

Already completed account, client and context setup? Go directly to
[the saved-playbook test](05-test-playbooks.md). Use the
[copy-ready test prompt](../setup/prompts/test-saved-business-plugin.txt), supply
the exact saved item and use the mission question unchanged. Discovery must
retrieve/read the actual guidance; a title/summary or manually pasted guidance
is not proof of saved-plugin use.

Live end-to-end installation, connector tool parity, source readiness and saved
playbook discoverability remain **NOT VERIFIED** until actually tested.
Report reproducible issues at [LAB670 issues](https://github.com/microsoft/ignite26-LAB670/issues)
without credentials, private configurations or ledgers.

**Start:** [Step 1: create or sign in to your GitHub account](01-github-account.md).
