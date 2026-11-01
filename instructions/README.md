# LAB670: Build your first Microsoft IQ playbook

## First: what is Microsoft IQ?

Microsoft IQ connects workplace context, business data and institutional
knowledge so agents can use the right sources for a business question.
This lab focuses on choosing that context and writing reusable playbook
guidance.

### Your enterprise intelligence, brought together

| Context source | What it contributes | Example at Zava |
|---|---|---|
| Work IQ | How employees work: workplace conversations, meetings and files | Avery's MBR request, review decisions and the current policy document |
| Fabric IQ | How the business operates: analytical data, semantic models and business relationships | Revenue/margin measures, fulfillment analysis, data agents and supplier/batch ontology |
| Foundry IQ | Institutional knowledge from curated knowledge sources | Department knowledge and controlling policy passages |
| Web IQ | Context from selected web references | Approved market bulletins or authoritative technical guidance |
| Business connectors | Context from other business systems | Salesforce commitments, Asana recovery tasks, ServiceNow incidents and Azure DevOps release evidence |

These are complementary sources, not interchangeable answers. For example,
a meeting can explain a commitment, but the financial model owns the revenue
measure. Use the provider that owns each sub-question, not every provider for
every prompt.

### Why agents need playbooks

When a new employee joins Zava, a handbook, wiki or Teams site tells them where
to find the information needed for their job. Agents need the same orientation.
A **playbook** makes that routing explicit: *when you need to do this, use
these sources and follow this guidance*.

Microsoft IQ playbooks provide a central place to **curate, discover and use
organizational context** across agents and tools. They connect a business
process to selected enterprise references and reusable guidance, rather than
require every user to rediscover the right files, models and policies.

For Zava's MBR: use the manager's request to establish intent, the authoritative
Finance model for financial measures, Operations for fulfillment, and the
current policy for decision rules. A similarly named archive report or a
copied policy is not an equally good substitute.

For your first playbook, keep the structure simple: one process, its relevant
context and clear guidance.

Think of your playbook as the process's **working guide**, not a saved monthly
answer: when to use it, which sources own which questions, how to resolve
conflicts, what to produce and which actions require human approval. A
supported agent client uses the saved context, while the underlying providers
still supply the actual evidence and current data.

| Concept | What it means for your Zava workday |
|---|---|
| Business process | Prepare an MBR, review a customer, assess a launch or investigate an incident |
| Curated references | Deliberately selected documents, conversations, reports/models, knowledge and business records |
| Reusable guidance | Scope, source routing, authority/freshness, reconciliations and draft-output boundaries |
| Using the playbook | Ask Copilot with the saved context and check its cited sources |
| Human review | Verify citations, numbers, unresolved evidence and the actual document/app draft |

A playbook does **not** grant permissions, turn copies into independent
evidence, freeze current KPIs, or authorize sends and business-system changes.
Check the cited evidence rather than rely on a convincing response.

Now put this into practice: start your Zava workday, ask Copilot, curate your
first MBR playbook, save/reopen it, then ask again and inspect the deliverable.

## Your workday at Zava

You are a business analyst at **Zava**, a fictional equipment and replenishment-services enterprise. You support Avery Chen, the Commercial Director. Zava has grown faster than its information architecture: decisions sit in email and meetings, policies in SharePoint, performance in dashboards and semantic models, supplier relationships in an ontology, and execution state in business applications.

Your manager asks:

> "Our monthly business review is coming up. Prepare a decision-ready September review: how are revenue, margin and fulfillment tracking, which commitments are at risk, and what should we investigate next? Give me a cited draft I can review, not another collection of dashboard links."

The lab's fictional review takes place in October 2026. Use September 2026, USD and the business-content cutoff **2026-10-06T18:00:00Z**. These are scenario dates, not your real clock or a calendar invitation. Preserve actual retrieval and source-refresh times separately.

In the Zava story, hundreds of files and meeting/email records, multiple
analytical models and reporting perspectives, department knowledge and
business-system records create a context silo. Some files are copies; some
policies are superseded; several reports share the display name **Zava MBR**.
A title alone cannot tell you which one owns a financial claim.

**You are a Zava business user, not the setup administrator.** Your work is to
curate useful context, save a playbook and use it to produce a grounded
business deliverable.

If the business context is not available yet, complete S02's creation and
guidance steps first. Return to source selection and the S01/S03 comparison
when the sources are available. An empty playbook is not evidence for Zava's
business results.

### Choose your path

| What you have | Follow this path | What you finish with |
|---|---|---|
| Microsoft IQ, Zava sources and Copilot with playbook selection | S01 -> S02 -> S03 -> S04 -> S05 | Two saved process playbooks, an evidence-based comparison, an internal draft and a connected-process design |
| Microsoft IQ, but sources or Copilot playbook selection are not yet available | S02 name/guidance/save -> S04 second playbook -> S05 design | Two saved playbooks and a connected-process design; add sources and test answers later |

You do not need all twelve process playbooks. The guided lab uses the MBR
and **one** specialist process. The other recipes are optional extensions.

## Agenda

| Part | Proposed time | What you accomplish |
|---|---|---|
| [Start your day](#orientation-and-setup) | 5 minutes | Confirm your issued user, client and ready sources |
| [S01: Ask Copilot before curation](#s01-baseline-and-context-gaps) | 8 minutes | Observe the answer and its evidence gaps |
| [S02: Curate your MBR playbook](#s02-create-and-curate-your-first-playbook) | 22 minutes | Choose authoritative cross-estate context, save and reopen |
| [S03: Ask again and build your deliverable](#s03-scope-and-guidance-composition) | 15 minutes | Compare grounded output in a clean session |
| [S04: Change your business hat](#s04-review-a-curation-proposal) | 15 minutes | Curate one role-specific process |
| [S05: Design Zava's agent factory](#s05-draft-a-work-iq-briefing) | 7 minutes | Package repeatable, approval-bounded business work |
| [Debrief](#debrief-and-finish) | 3 minutes | Show evidence, gaps and no-action boundaries |

Plan for about 75 minutes. Additional persona scenarios and connected-process
practice are self-paced extensions, not all mandatory within that time.

## Orientation and setup

### Open your lab tools

Sign in with your learner account and open Microsoft IQ and Copilot from the
lab links. Ask the instructor for the workspace and source list if you cannot
find them.

| Item | What to find |
|---|---|
| Microsoft IQ | Playbook list and New playbook or Create |
| Lab workspace | Where you will save your own playbooks |
| Learner prefix | A prefix such as your first name to distinguish your drafts |
| Copilot | A fresh conversation for each comparison |
| Zava sources, when available | Relevant files, reports/models, knowledge, web references and business records |

You do not need to install or provision anything. If sources are missing, finish
the playbook's name, description and guidance and return to context selection later.

### What you are building

A playbook records **when a process applies, which sources own which questions, how to reconcile evidence, and what output/actions are allowed**. It is not a frozen monthly answer or an access grant.

Your first draft is `<your-prefix> Zava Monthly Business Review`. Start with a
description, relevant context and reusable guidance.

Use the Zava business sources available in the lab. Do not substitute unrelated
data or copy another person's restricted context.

All business outputs are **internal drafts**. Do not send, invite, assign, purchase, approve spend, alter accounting entries, close incidents, update CRM/task records, publish apps, change permissions or delete resources.

<a id="s01-baseline-and-context-gaps"></a>

## S01: Ask Copilot before curation

### Ask Copilot as you start your day

Use a clean conversation and submit this prompt. Save the response privately, including any citations and disclosed source gaps.

```text
I am preparing Zava's September 2026 monthly business review for my manager.
Use USD and evidence effective by 2026-10-06T18:00:00Z. Reconcile revenue,
margin, fulfillment and customer commitments. Prepare a cited internal draft,
identify exceptions and missing evidence, and propose role-based next steps.
Do not send, approve, assign, publish or update any business record.
```

Do not force Copilot to fail. It may already give a good answer. Keep the same tools and source permissions enabled before and after curation.

Inspect the response:

| Question | What to record |
|---|---|
| Which files and conversations supported the narrative? | Actual sources read, not plausible document titles |
| Which **Zava MBR** report was used? | Exact report, workspace, model lineage, audience and reporting period |
| Were repeated files treated as separate evidence? | Same-source copies and alternate formats, not an inflated corroboration count |
| Was the policy current? | DOC-03 version 2 versus superseded DOC-02 |
| Were metrics comparable? | Actual/Budget, account, period, currency and measure definitions |
| What could not be verified? | Missing sources, stale data or claims without supporting citations |

**Checkpoint:** explain what the answer supports and what it does not.
"It sounds convincing" is not a source-selection test.

<a id="s02-create-and-curate-your-first-playbook"></a>

## S02: Curate your MBR playbook

### 1. Define the business process

Follow [Create your first playbook](zava-business-playbooks.md#create-your-first-playbook).
Use your learner prefix and select the lab workspace. Keep membership unchanged.

In the description and guidance, explain that this playbook prepares an
internal MBR for business-review analysts and managers. This describes the
business audience; it does not require inviting anyone or changing access.

Copy the [common guidance](zava-business-playbooks.md#common-guidance-include-in-every-candidate),
then add the [MBR process guidance](zava-business-playbooks.md#monthly-business-review).
Save and reopen your playbook before selecting sources. Keep monthly numeric
answers out of reusable guidance.

### 2. Curate evidence, not a folder dump

When the sources are available, open the add-context control, preview the Zava
sources and select the **smallest relevant authoritative set**. Hundreds of
available files are background context, not a requirement to attach everything.

| Context | Select for this MBR | Why it belongs |
|---|---|---|
| Work IQ | Current review charter, manager request/decisions, current policy, relevant operating review and meeting/email evidence | Business intent, authority, disputed commitments and recorded decisions |
| Fabric IQ reports/models | The issued Finance report/model for financial measures; Commercial for bookings/deferral; Operations for fulfillment/freight | The source that owns each quantitative question |
| Fabric data agent | The review agent using the relevant models | An analytical route whose underlying sources you can check |
| Fabric ontology | Relevant batch, supplier, period and recovery-task relationships | Investigation context, not proof of cause or a second financial total |
| Web IQ | Current Zava market bulletin | External context and publication freshness, not Zava's shipment cause |
| Foundry IQ | Current-policy collection and relevant operations/commitment knowledge sources | Retrieved policy passages and supporting evidence with versions |
| Business connectors | Relevant Salesforce opportunities, Asana recovery tasks and ServiceNow incidents | Recorded business-system state rather than commentary |

If a source is unavailable, leave it out and record the missing evidence.
Ask the instructor for help; do not substitute unrelated data.

### 3. Resolve identical report names and duplicate files

For each result titled **Zava MBR**, inspect its workspace, business owner,
audience, underlying model, reporting period, currency and refresh. Distinguish
the following reporting purposes:

| Same display title | Intended use | Curation decision |
|---|---|---|
| Zava MBR in the approved Finance scope | Finance Actual/Budget, recognized revenue and profit | Select for financial claims after lineage/schema checks |
| Zava MBR in the approved Commercial scope | Bookings, opportunity state and deferral | Select for commercial questions; do not substitute for recognition |
| Zava MBR in the archive scope | Prior period or superseded perspective | Do not use as current authority |

Use the actual workspace and model information in the source preview.
If lineage is ambiguous, ask for help rather than choose the first result.

For repeated policies or meeting copies, identify the source family, version and effective date. Word, email, transcript and indexed copies of the same discussion are not independent corroboration. Preserve a historical source only when the task requires comparison and label it historical.

### 4. Add reusable routing and output guidance

Review the guidance you saved in step 1. Check that it explains which source
owns each question, how to handle conflicts and what the internal draft should
contain. You do not need to write model queries yourself.

For each selected source, be able to explain **why it belongs, who owns it,
whether it is current and whether it copies another source**. Use the source
preview and metadata rather than its display name alone.

### 5. Review, save, leave and reopen

Review the context and guidance, save, return to the playbook list and reopen
your draft. Check that the description, guidance and selected sources are present.

**Checkpoint:** show your saved playbook and explain the guidance. Once context
is available, explain why each source belongs and which same-named report
you rejected.

<a id="s03-scope-and-guidance-composition"></a>

## S03: Use curated context for your deliverable

### Ask again using the saved playbook

Start a new conversation with the same learner account, Copilot settings and
source access. Select or discover your saved playbook. Do not paste the baseline
answer into this conversation.

If Copilot does not offer a way to use your saved playbook, ask the instructor
and continue with S04/S05's creation and design steps. Pasting guidance into a
prompt is not the same as using the saved playbook.

Submit the **same S01 prompt**. Check the cited source bodies, report/model
lineage, measures and filters.

Compare before and after:

| Dimension | Evidence of a useful change |
|---|---|
| Source selection | Correct current policy and exact report/model route, not name matching |
| Grounding | Claim-level citations that open and support the statement |
| Reconciliation | Bookings separated from recognized revenue; compatible Actual/Budget comparisons |
| Completeness | Available Work decisions, analytical exceptions and business-system state considered |
| Uncertainty | Duplicate families, stale sources, missing acceptance and provider gaps remain visible |
| Safety | No message, permission change, business-system mutation or publication occurred |

Report unchanged quality or regressions honestly. Curation does not guarantee
that every answer is correct.

### Turn the answer into a review deliverable

After the same-prompt comparison, ask:

```text
Using the reviewed Zava MBR evidence and saved playbook, prepare a manager-ready
internal MBR document: executive summary, scope/as-of, KPI table with units and
source references, exceptions, unresolved evidence, and proposed role-based
next steps. Keep bookings separate from recognized revenue and hypotheses
separate from proven causes. Create a Word draft if this client supports it;
otherwise provide structured document content and state that no file was made.
Do not send, publish, approve, assign or update records.
```

Open any actually created file and verify the contents, citations and numeric provenance. Do not accept a filename or download button as proof of a correct document.

**Optional app output:** if your client offers app creation, request a private,
read-only MBR draft using the same evidence. Check KPI sources, freshness,
units and gaps. Preview it without deployment or sharing. Otherwise, keep the
document draft.

<a id="s04-review-a-curation-proposal"></a>

## S04: Change your business hat

### Choose one specialist process

The MBR raises a question needing deeper work. Choose one [persona scenario](zava-scenarios.md):
operations, finance, sales, service, procurement or data stewardship. Alternatively,
choose a customer, campaign, checkout, policy or launch process from the hero
recipes. Use a process with sources available to you for Copilot testing.
The MBR is one entry point, not the only business process.

A persona changes the business question and guidance, not your account or
permissions. Keep your learner account and use only sources you can access.

Create a **separate role-specific playbook with your learner prefix** instead
of adding every specialist rule to the MBR. Read the matching
[business-process recipe](zava-business-playbooks.md). Copy the common guidance
and that process's guidance, then save and reopen it.

When sources are available, preview the relevant evidence. You can ask
Copilot for source-selection suggestions:

```text
For my selected Zava business process, suggest sources to include or leave out.
Explain which question each source answers, whether it is current and whether
it duplicates another source. Use only sources you can read. Do not change
the playbook or any business record.
Separate a proposed owner/date from recorded business-system state.
```

Review each suggestion before selecting context in your own playbook. Save and reopen it,
then run the scenario prompt in a fresh conversation when the business sources
are available. Review its business deliverable.

**Checkpoint:** show a second saved playbook with a different question and
guidance. With sources available, show its focused source set and cited
internal draft. Without sources, explain what evidence you will add later.

<a id="s05-draft-a-work-iq-briefing"></a>

## S05: Design Zava's agent factory

### From one playbook to Zava's agent factory

Now connect two business processes. Each playbook defines a question, relevant
sources and an internal draft. You review the first draft before passing its
supported findings to the next process. Each process has a human reviewer;
saving the playbooks does not automatically run the chain.

Choose a [connected business journey](zava-agent-factory.md#choose-a-connected-journey):
commitment-to-revenue assurance, market-to-commerce launch, or
incident-to-customer assurance. Each has non-MBR entry points, conditional
branches and explicit evidence handoffs. Turn at least two connected processes
into catalog entries:

| Field | What to specify |
|---|---|
| Process and human owner role | MBR analyst, operations lead, finance controller or another selected role |
| Trigger | The business request that starts the process |
| Context | Relevant sources, authority, freshness and reader access |
| Work to automate | Retrieve, reconcile and draft a review/document or read-only app |
| Human handoff | Review evidence and accept/reject proposed next steps |
| Restricted actions | Sends, assignments, purchases, accounting entries, incident/CRM writes and deployment |
| Checks | Grounding, filters, conflicts, duplicate provenance, gaps and no-action evidence |
| Maintenance | Saved version, review owner and what to revisit after sources change |

Draft a briefing showing the selected route, upstream/downstream dependencies,
the [shared evidence handoff](zava-agent-factory.md#the-shared-evidence-handoff-contract),
the human reviewer and a missing-evidence stop condition. State which sources
the downstream process must independently read and how duplicate provenance
survives final synthesis. Integration is more than two unrelated catalog entries.

Use this template to keep the design short:

```text
Business request: [what a Zava colleague needs].
First process: [name and purpose].
Next process: [name and why it follows].
Handoff: [supported findings, citations, scope and unresolved questions].
Next process checks: [its own sources and the relevant record identifiers].
Stop if: [the evidence needed for the next conclusion is missing].
Human reviewer: [business role, not a new assignment].
Output: internal draft only; no sends, record updates, purchases or deployment.
```

For a self-paced extension, [rehearse at least two steps with Copilot](zava-agent-factory.md#rehearse-the-chain-with-copilot)
and run the integration checks. Use separate saved playbooks and user-reviewed
packet handoffs in clean sessions. This additional rehearsal is outside the
seven-minute design exercise. You guide the handoffs between conversations;
saving playbooks alone does not automatically run a workflow.

This exercise ends with a reviewed draft and a process design. Do not create
schedules, deploy agents or change business records. Future implementation
must follow Zava's normal approval and access controls.

## Provider concepts

Provider concepts are exercised through business questions, not a separate connection/setup tour. Work IQ owns workplace intent and decisions; Fabric models own quantitative measures; data agents expose an analytical route; ontologies expose relationships; Web IQ supplies external context; Foundry IQ retrieves knowledge passages; business connectors own recorded state.

Use only sources your learner account can read. Changing business hats or
sharing a playbook does not grant source access or make a copied report
independent evidence.

## Safe recovery and troubleshooting

| Problem | Safe response |
|---|---|
| A source or Copilot is unavailable | Finish the playbook guidance and process design; ask the instructor before testing |
| Copilot has no playbook selection option | Ask the instructor; do not present pasted guidance as use of the saved playbook |
| The optional cover cannot be saved | Skip the cover and continue; it does not affect the business guidance |
| Reports share a title or lineage is unclear | Inspect issued ownership/model/period metadata; defer selection if unresolved |
| A source is stale, duplicated or superseded | Retain provenance and current authority; do not count copies as independent facts |
| A body, model or connector is inaccessible | Record the gap; do not broaden permissions or copy another user's data |
| Save/reopen does not match the reviewed draft | Record the difference and stop before claiming persistence |
| An answer has no usable source citations | Ask for supporting evidence and retain the gap |
| Document or app creation is unavailable | Keep structured document content; do not claim a file or app was created |

If reopening or retrying once does not help, ask the instructor. Keep your
account, source access and business records unchanged.

## Debrief and finish

**Everyone:**

- [ ] Saved and reopened the MBR playbook with common and process guidance.
- [ ] Created one specialist playbook without changing account or access.
- [ ] Designed a two-process handoff with a human reviewer and a missing-evidence stop condition.

**With sources and Copilot playbook selection available:**

- [ ] Captured the baseline without forcing a poor answer.
- [ ] Selected current sources and resolved same-named reports and copies.
- [ ] Repeated the same prompt in a fresh conversation using the saved playbook.
- [ ] Compared citations, reconciliations, gaps and safety—not just writing style.
- [ ] Reviewed the internal document draft or structured content.

Tell your manager what improved, what stayed the same and what still needs
evidence. If you followed the creation-only path, show the two playbooks and
design instead of claiming a business answer was tested. Leave business records
and shared sources unchanged.
