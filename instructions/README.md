# LAB670: Build your first Microsoft IQ playbook

## First: what is Microsoft IQ?

**Trusted agents need trusted context.** Microsoft IQ brings organizational
intelligence together so agents can understand how employees work, how the
business operates and the institutional knowledge behind its decisions. Its
broader platform connects this context with agent capabilities and enterprise
governance. This lab focuses on **Microsoft IQ context and playbooks**.

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

The broader playbook model includes hierarchical organization with inherited
context, certification, sensitivity labeling, governance and auditability.
These are product concepts, **not claims that every feature is available or
verified in this lab build**. Use native hierarchy and governance controls only
when supported and admitted; otherwise follow the explicitly reviewed flat
composition in the workbook.

Think of your playbook as the process's **context contract**, not a saved monthly
answer: when to use it, which sources own which questions, how to resolve
conflicts, what to produce and which actions require human approval. An admitted
Copilot or custom-agent client applies the saved context, while the underlying
providers still supply the actual evidence and current data.

| Concept | What it means for your Zava workday |
|---|---|
| Business process | Prepare an MBR, review a customer, assess a launch or investigate an incident |
| Curated references | Deliberately selected documents, conversations, reports/models, knowledge and business records |
| Reusable guidance | Scope, source routing, authority/freshness, reconciliations and draft-output boundaries |
| Playbook consumption | Use the saved context through the issued supported client, then read authorized sources |
| Human review | Verify citations, numbers, unresolved evidence and the actual document/app draft |

A playbook does **not** grant permissions, turn copies into independent
evidence, freeze current KPIs, or authorize sends and business-system changes.
Supported curation and consumption routes vary by the issued build and
admission. You will check what actually worked rather than assume integration
from a convincing response.

Now put this into practice: start your Zava workday, ask Copilot, curate your
first MBR playbook, save/reopen it, then ask again and inspect the deliverable.

## Your workday at Zava

You are a business analyst at **Zava**, a fictional equipment and replenishment-services enterprise. You support Avery Chen, the Commercial Director. Zava has grown faster than its information architecture: decisions sit in email and meetings, policies in SharePoint, performance in dashboards and semantic models, supplier relationships in an ontology, and execution state in business applications.

Your manager asks:

> "Our monthly business review is coming up. Prepare a decision-ready September review: how are revenue, margin and fulfillment tracking, which commitments are at risk, and what should we investigate next? Give me a cited draft I can review, not another collection of dashboard links."

The lab's fictional review takes place in October 2026. Use September 2026, USD and the business-content cutoff **2026-10-06T18:00:00Z**. These are scenario dates, not your real clock or a calendar invitation. Preserve actual retrieval and source-refresh times separately.

Zava has hundreds of files and meeting/email records, twenty analytical model definitions, multiple reporting perspectives, three knowledge collections, and third-party business records. The provisioned lab should expose approved reports and dashboards over those models. Some files are copies; some policies are superseded; several reports intentionally share the display name **Zava MBR**. A title alone cannot tell you which one owns a financial claim.

**You start as a Zava user in a prepared environment. You do not generate, upload, hydrate or deploy context.** The provisioning team completes those tasks before the lab. Your work is to curate useful context, save a playbook and use it to produce a grounded business deliverable.

**Validation status:** the journey and source definitions are implemented. Actual tenant hydration, report/dashboard admission, native curation, source reads, Copilot outputs and target-build screenshots require rehearsal. A prepared environment is a delivery prerequisite, not a claim that it has already been verified.

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

The 75-minute schedule is proposed and unrehearsed. Additional persona scenarios are self-paced extensions, not all mandatory within that time.

## Orientation and setup

### What should already be ready

Sign in using the issued learner identity and open the issued Copilot and Microsoft IQ clients. The instructor gives you a **learner-safe source card**, not an administrator runbook or private deployment report.

| Issued item | Your readiness check |
|---|---|
| Zava identity and approved client | Confirm your own account and admitted target build |
| Private authoring location and learner namespace | Confirm where you may create drafts without sharing or changing permissions |
| Work sources | Open the current review request/policy and an admitted email or meeting source |
| Reporting catalog | Find the issued reports, their owning workspaces and underlying semantic models |
| Fabric data agents and ontology | Confirm the assigned published agent and readable, refreshed relationship source |
| Web and Foundry IQ | Confirm issued HTTPS references and admitted knowledge-retrieval connections |
| Business connectors | Confirm read-only Salesforce, Asana and ServiceNow references, where admitted |
| Source card and support | Check authority, business period, freshness, exact locator and permitted reader for each source |

If a lane is missing, contact the instructor. Do not install clients, create tenants, upload archives, consent to plugins, buy capacity or run hydration scripts. An explicitly labelled manual source-reading lane can support a partial rehearsal; it is not proof of native provider retrieval.

### What you are building

A playbook records **when a process applies, which sources own which questions, how to reconcile evidence, and what output/actions are allowed**. It is not a frozen monthly answer or an access grant.

Your first draft is `<your-namespace> Zava Monthly Business Review`, with Overview, Evidence and Review Output sections if the issued UI supports sections. Use an explicitly reviewed flat composition if it does not; do not invent native inheritance.

Use only authorized Zava synthetic sources. Do not attach this implementation repository, source-generator code, manifests, private tenant configuration, instructor answers or another role's restricted fixtures to the consuming agent. Operational files under `infra` and source fixtures under `data` are for the provisioning team; they are not a shortcut around native reads.

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
| What could not be verified? | Missing permissions, stale refresh, unavailable providers or unknown tool traces |

**Checkpoint:** explain what the answer supports and what it does not. "It sounds convincing" is not a source-selection test. Do not infer tool execution from progress narration.

<a id="s02-create-and-curate-your-first-playbook"></a>

## S02: Curate your MBR playbook

### 1. Define the business process

Open your issued Microsoft IQ authoring location. Create your namespaced **Zava Monthly Business Review** draft. Confirm visibility before saving; creating a draft does not authorize organization-wide sharing.

Set its purpose to preparing an internal MBR, its audience to business-review analysts and managers, and its avoid conditions to unrelated periods/accounts, external communications and consequential actions.

Use the [complete common and MBR guidance](zava-business-playbooks.md#common-guidance-include-in-every-candidate). Keep monthly numeric answers out of reusable guidance.

### 2. Curate evidence, not a folder dump

Open the supported add-context/source picker. Search within the issued Zava scope, preview full sources, then select the **smallest relevant authoritative set**. Hundreds of available files are background context, not a requirement to attach everything.

| Context | Select for this MBR | Why it belongs |
|---|---|---|
| Work IQ | Current review charter, manager request/decisions, current policy, relevant operating review and meeting/email evidence | Business intent, authority, disputed commitments and recorded decisions |
| Fabric IQ reports/models | The issued Finance report/model for financial measures; Commercial for bookings/deferral; Operations for fulfillment/freight | The source that owns each quantitative question |
| Fabric data agent | The published review agent whose selected sources match the admitted models | A supported analytical route with inspectable underlying provenance |
| Fabric ontology | Relevant batch, supplier, period and recovery-task relationships | Investigation context, not proof of cause or a second financial total |
| Web IQ | Issued current synthetic HTTPS market bulletin | External context and publication freshness, not Zava's shipment cause |
| Foundry IQ | Current-policy collection and relevant operations/commitment knowledge sources | Retrieved policy passages and supporting evidence with versions |
| Business connectors | Relevant Salesforce opportunities, Asana recovery tasks and ServiceNow incidents | Recorded business-system state rather than commentary |

Do not attach an unavailable connection or label a local file as a live URL/agent. Ask support to admit the lane; keep the gap visible.

### 3. Resolve identical report names and duplicate files

For each result titled **Zava MBR**, inspect its workspace, business owner, audience, underlying model, definitions, reporting period, currency/scenario, refresh and authority. The provisioned source card should distinguish:

| Same display title | Intended use | Curation decision |
|---|---|---|
| Zava MBR in the approved Finance scope | Finance Actual/Budget, recognized revenue and profit | Select for financial claims after lineage/schema checks |
| Zava MBR in the approved Commercial scope | Bookings, opportunity state and deferral | Select for commercial questions; do not substitute for recognition |
| Zava MBR in the archive scope | Prior period or superseded perspective | Do not use as current authority |

These are provisioning requirements, not invented native workspace names or verified deployed reports. Use the exact issued bindings. If lineage is ambiguous, stop and resolve it rather than choosing the first search result.

For repeated policies or meeting copies, identify the source family, version and effective date. Word, email, transcript and indexed copies of the same discussion are not independent corroboration. Preserve a historical source only when the task requires comparison and label it historical.

### 4. Add reusable routing and output guidance

Specify the reporting scope; full-body/source-version checks; which provider owns each question; analytical measures and filters; conflict/copy handling; and the internal-draft boundary.

For every selected reference, record: **task fit, owner/authority, version, business period, refresh, exact locator, permitted reader and duplicate family**. Never infer access from playbook membership or hierarchy.

### 5. Review, save, leave and reopen

Review the complete reference basket and guidance before confirming. Save using the issued supported control, leave the item, reopen it and inspect the full persisted guidance and references. Check local versus inherited origins where the UI exposes them; placement alone does not establish inheritance.

**Checkpoint:** show the saved MBR draft, why each source was chosen, which same-named report was rejected, and a visible source/provider gap if one exists. A proposal, screenshot or local Markdown file alone is not saved native state.

See [the native screenshot checkpoints](zava-business-playbooks.md#msit-authoring-and-screenshot-checkpoints). Only actual, reviewed and redacted target-build captures belong in the guide.

<a id="s03-scope-and-guidance-composition"></a>

## S03: Use curated context for your deliverable

### Ask again using the saved playbook

Start a distinct clean conversation under the same issued identity and client/model configuration. Select or discover the saved playbook through the admitted supported path. Do not paste the baseline answer as hidden context.

Submit the **same S01 prompt**. Inspect the actual playbook/guidance activation, cited source bodies, report/model lineage, measures and filters. Missing trace access remains unknown, not a successful retrieval event.

Compare before and after:

| Dimension | Evidence of a useful change |
|---|---|
| Source selection | Correct current policy and exact report/model route, not name matching |
| Grounding | Claim-level citations that open and support the statement |
| Reconciliation | Bookings separated from recognized revenue; compatible Actual/Budget comparisons |
| Completeness | Work decisions, analytical exceptions and business-system state considered where admitted |
| Uncertainty | Duplicate families, stale sources, missing acceptance and provider gaps remain visible |
| Safety | No message, permission change, business-system mutation or publication occurred |

Report unchanged quality or regressions honestly. One paired exercise is not a measured production uplift or a guarantee that curation always makes an answer correct.

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

**Optional Rayfin app output:** only if the issued client exposes that capability, request a private, read-only MBR app draft over the same admitted evidence. Require KPI provenance, freshness, units, gaps and no write-back or hard-coded invented values. Preview it without deployment or sharing. If unavailable, retain the document and record the app lane as blocked; an HTML mockup is not a tested Rayfin integration.

<a id="s04-review-a-curation-proposal"></a>

## S04: Change your business hat

### Change your business hat

The MBR raises a question needing deeper work. Choose one [persona scenario](zava-scenarios.md): operations, finance, sales, service, procurement or data stewardship.

A persona changes the business question and guidance—not your real identity or permissions. Use the same learner account unless the instructor explicitly issues a separate role account and clean session. Do not borrow a fictional colleague's credentials or copy context across security boundaries.

Create a **separate namespaced role-specific playbook** instead of adding every specialist rule to the MBR. Read the matching [business-process recipe](zava-business-playbooks.md), preview its admitted references and review a curation proposal:

```text
For my selected Zava business process, propose a curation diff: the question,
sources to add or omit, exact source/model fit, authority and freshness,
duplicate handling, output and action boundaries. Do not apply the proposal.
Separate a proposed owner/date from recorded business-system state.
```

Accept, omit or defer each suggestion. Manually apply only individually approved changes to your own draft, save, leave, reopen and inspect. Run the scenario prompt in a fresh conversation and review its business deliverable.

**Checkpoint:** demonstrate a changed persona/question, a deliberately different source set, persisted guidance and a cited internal draft—not a source-system action.

<a id="s05-draft-a-work-iq-briefing"></a>

## S05: Design Zava's agent factory

### From one playbook to Zava's agent factory

An **agent factory** is a governed catalog of reusable business-process specifications. Each process has a human owner, applicability, authorized context, expected output, evaluation checks and an approval boundary. It is not a fleet with blanket enterprise write access.

Turn your MBR and specialist process into two catalog entries:

| Field | What to specify |
|---|---|
| Process and human owner role | MBR analyst, operations lead, finance controller or another selected role |
| Trigger | A user request in this lab; a future schedule/event is only a design proposal |
| Context contract | Exact admitted sources, lineage, authority, freshness and permitted reader |
| Work to automate | Retrieve, reconcile and draft a review/document or read-only app |
| Human handoff | Review evidence and accept/reject proposed next steps |
| Restricted actions | Sends, assignments, purchases, accounting entries, incident/CRM writes and deployment |
| Checks | Grounding, filters, conflicts, duplicate provenance, gaps and no-action evidence |
| Lifecycle | Version, saved readback, review owner and revalidation after source changes |

Draft a briefing explaining how these two processes could be reused by Copilot or an approved custom harness. A harness must use authenticated Microsoft IQ retrieval and source adapters with the same authorization/safety contract; a copied local skill file is not proof of service retrieval.

Do not create schedules, deploy agents or mutate systems during this exercise. Any operational automation needs its own exact targets, permission/cost plan and explicit approval.

## Provider concepts

Provider concepts are exercised through business questions, not a separate connection/setup tour. Work IQ owns workplace intent and decisions; Fabric models own quantitative measures; data agents expose an analytical route; ontologies expose relationships; Web IQ supplies external context; Foundry IQ retrieves knowledge passages; business connectors own recorded state.

Preserve source permissions and RLS/CLS/OLS. A role change, playbook share, agent route or duplicated report does not grant access or create independent evidence.

## Safe recovery and troubleshooting

| Problem | Safe response |
|---|---|
| Provisioned source or client is unavailable | Contact the instructor; participants do not hydrate or buy services |
| Reports share a title or lineage is unclear | Inspect issued ownership/model/period metadata; defer selection if unresolved |
| A source is stale, duplicated or superseded | Retain provenance and current authority; do not count copies as independent facts |
| A body, model or connector is inaccessible | Record the gap; do not broaden permissions or copy another user's data |
| Save/reopen does not match the reviewed draft | Record the difference and stop before claiming persistence |
| Playbook activation or provider traces are not visible | Mark unknown; do not infer calls from the answer |
| Word/Rayfin output is unavailable | Keep a structured draft and explicitly label the missing artifact |

Use at most two documented safe retries without changing identity or scope, then contact support. Deletion, resets, permission changes and tenant repair are operator-only and separately approved.

## Debrief and finish

- [ ] Captured the baseline without forcing a poor answer.
- [ ] Selected current sources and disambiguated same-named reports by lineage, owner and scope.
- [ ] Saved/reopened the MBR playbook and inspected complete guidance/references.
- [ ] Repeated the same prompt in a clean session and compared actual evidence.
- [ ] Reviewed a document or explicitly labelled unavailable artifact.
- [ ] Curated one different persona/process without changing access.
- [ ] Designed two approval-bounded agent-factory entries; deployed no autonomous actions.

Leave business records and shared sources unchanged. Retain only approved, redacted evidence. Report completed, blocked and unverified capabilities separately.
