# LAB670: Build your first Microsoft IQ Business plugin

## First: what is Microsoft IQ?

Microsoft IQ connects workplace context, business data and institutional
knowledge so agents can use the right sources for a business question.
A **business plugin** pairs selected sources with reusable guidance: when to use
them, which questions they answer and what to produce.

| Context | What it answers | Zava example |
|---|---|---|
| Work IQ | What did people request, discuss or decide? | The manager's email, review charter and customer commitments |
| Fabric IQ | What do the business measures show? | Revenue, margin, bookings, fulfillment and freight |
| Foundry IQ | Which institutional knowledge or policy applies? | Recognition rules, expedite review and decision roles |
| Business connectors | What state is recorded in business applications? | Salesforce opportunities, Asana tasks and ServiceNow incidents |
| Web IQ | What external information provides useful context? | A market bulletin or authoritative technical guidance |

A business plugin is a working guide, not a saved answer or a permission grant.
Choose the sources that own the question rather than attach everything.

## Your challenge: save Zava's business review

You are a business analyst at **Zava**, an equipment and replenishment-services
enterprise. Your manager, Avery Chen, sends this request:

> "The September business review is coming up. Sales says we had a strong
> month, Operations is worried about fulfillment, and Finance wants us to
> check recognition. Give me a review I can trust, then show how the teams
> can reuse this work next time."

The evidence is scattered across emails, meetings, policies, reports and
business applications. Several reports have the same name, **Zava MBR**.
Some documents are copies; one policy is superseded. A confident answer
can still use the wrong source.

You will solve six business challenges, get feedback from a Copilot judge,
improve your business plugins and save a reusable Zava agent-factory catalog.
The learning path introduces one kind of context at a time before combining it.

Use **September 2026, USD and business evidence effective by
2026-10-06T18:00:00Z**. This is a fictional October review, not today's date.
Keep source-refresh and actual retrieval times separate.

## Your mission board

| Mission | Business problem | Context you curate | Deliverable |
|---|---|---|---|
| [1. Decode the request](#mission-1-decode-the-request-with-work-iq) | What does Avery actually need? | Work IQ | Review brief |
| [2. Find the right numbers](#mission-2-find-the-right-numbers-with-fabric-iq) | Which reports and measures support the story? | Fabric IQ | Scoped KPI evidence |
| [3. Resolve the policy](#mission-3-resolve-the-policy-with-foundry-iq) | What can Zava conclude or approve? | Foundry IQ | Policy and review-role checklist |
| [4. Build the MBR](#mission-4-combine-work-fabric-and-foundry-iq) | Can you turn the scattered evidence into a decision-ready review? | Work + Fabric + Foundry IQ | Internal MBR document |
| [5. Check commitments](#mission-5-check-commitments-with-work-iq-and-salesforce) | What can Sales substantiate before a handoff? | Work IQ + Salesforce | Commitment-risk brief |
| [6. Investigate recovery](#mission-6-investigate-recovery-with-iq-and-business-connectors) | What is known, proposed or still missing? | Work + Fabric + Foundry IQ + business connectors | Operations/recovery brief |
| [7. Publish your factory](#mission-7-publish-your-zava-agent-factory) | How will the teams reuse your business plugins together? | Your six saved business plugins | Saved process catalog and a reviewed handoff |

Allow about **90 minutes**: 5 to start, about 10 for each specialist mission,
15 for the combined MBR, 10 for the factory and 10 for feedback and debrief.
Additional customer, campaign, checkout and launch scenarios are
[optional extensions](zava-scenarios.md#hero-scenario-pathways).

## Lab setup prerequisites

Complete the separate **[lab setup prerequisites](lab-setup.md)** before Mission 1.
It covers first-time Fabric registration, the prepared-context route and the
instructor-approved quick PowerShell route. Allow an additional 5-10 minutes
only on a warm, prepared environment; cold tenant/capacity/indexing work is
not part of that target.

## Orientation and setup

Open Microsoft IQ and Copilot from the lab links using your learner account.
Find the lab workspace and source list. Choose a prefix, such as `Alex`, for
your business plugin names; do not type the brackets in `<your-prefix>`.

**Your boundary:** create your own business plugins and internal drafts. Keep
membership and source permissions unchanged. Do not send messages, assign
tasks, change business records, buy services or deploy applications.

If a mission's sources or Copilot business plugin selection are unavailable, create
its name, description and guidance, then move on to the next available
mission. Return to testing later. The judge cannot verify business answers
without the relevant evidence.

### The six steps you repeat

1. **Create.** Open **Business plugins** in Microsoft IQ and choose **New**
   or **Create** (the label may vary). Enter the mission's name and description.
   Select the existing lab workspace in the workspace/location field.
   Leave **Add members and curators** unchanged. Select **Create**.
2. **Guide.** Add the [common guidance](zava-business-plugins.md#common-guidance-include-in-every-candidate)
   and the mission's guidance block below. The business question is the test
   prompt, not the reusable guidance.
3. **Curate.** Open the add-context control. Search for the mission's sources,
   preview the actual content and metadata, select the relevant references
   and review the selection. Follow the provider-specific checks in each
   mission. Ask for help if you cannot identify the intended source.
4. **Save and reopen.** Save, return to the list and reopen your business plugin.
   Check the description, complete guidance and selected references.
5. **Solve.** Open a fresh Copilot conversation, select or discover the saved
   business plugin and submit the mission's question. Open the cited sources and
   inspect the result. If your client cannot select the business plugin, ask the
   instructor; pasted guidance is not the same as using the saved item.
6. **Judge and improve.** Use the [Copilot judge](zava-copilot-judge.md).
   Review its feedback, change your own guidance or source selection where
   needed, save/reopen and try the same question in another fresh conversation.

The [creation guide](zava-business-plugins.md#create-your-first-business-plugin)
includes the field examples and optional Zava cover.

### Keep a mission scorecard

Record this privately. Leave scores blank until the judge has checked evidence.

| Mission | Saved business plugin | Draft reviewed? | Judge score or evidence gap | Change for next attempt |
|---|---|---|---|---|
| 1: Work IQ | | | | |
| 2: Fabric IQ | | | | |
| 3: Foundry IQ | | | | |
| 4: Combined MBR | | | | |
| 5: Commitments | | | | |
| 6: Recovery | | | | |

Aim for **80/100 or better**, with evidence verified and no critical issue.
This is a classroom practice target, not certification. A missing-source
result is **needs evidence**, not a passing score. Do not force a poor
baseline or manufacture improvement.

<a id="s01-baseline-and-context-gaps"></a>

## Mission 1: Decode the request with Work IQ

**Business problem:** Avery needs a decision brief, but email opinions,
meeting notes and proposed actions are being mixed together.

Before creating this business plugin, ask the business question below once in a
fresh Copilot conversation and keep the response as your baseline. Then
create, curate and select the saved business plugin and ask the same question in
another fresh conversation, keeping the account, tools and source access fixed.

| Creation field | Enter |
|---|---|
| Name | `<your-prefix> Zava Review Brief` |
| Description | Clarify the review request, recorded decisions, open questions and business reviewer roles. |

**Curate Work IQ:**

1. Find Avery's current review request and the commercial review charter.
2. Preview relevant sales, operations, Finance and customer-commitment
   discussions. Read the messages or documents, not just search summaries.
3. Check who wrote each source, its date and whether it records a decision,
   an opinion or a proposal. Omit unrelated conversations and duplicate copies.
4. Keep this first business plugin focused on workplace evidence. Do not use an
   email's headline as the authoritative financial number.

Add this mission guidance after the common guidance:

```text
Clarify Avery's review request from workplace evidence. Identify recorded
decisions, opinions, unresolved questions and reviewer roles. Use source
dates and authors to explain conflicts. Do not turn a proposal into an
assignment or an email's sales claim into a Finance result. Produce a short
review brief and identify which questions need financial or policy evidence.
```

```text
What does Avery need for Zava's September 2026 review? Prepare an internal
brief with the business question, recorded decisions, conflicting opinions,
open evidence questions and reviewer roles. Cite the workplace sources.
Do not send messages, assign work or treat email commentary as financial proof.
```

**Submit to the judge:** the brief, source citations and this mission's request.
Ask it to check decisions versus proposals, relevant source selection and
whether the brief correctly identifies questions Work IQ alone cannot settle.

## Mission 2: Find the right numbers with Fabric IQ

**Business problem:** three reports say **Zava MBR**, but they do not answer
the same questions. Sales bookings and Finance revenue are not interchangeable.

| Creation field | Enter |
|---|---|
| Name | `<your-prefix> Zava Performance Review` |
| Description | Reconcile financial, commercial and fulfillment measures under a consistent reporting scope. |

**Curate Fabric IQ:**

**Quick-context variation:** the reduced setup supplies the three authoritative
models below, but no duplicate/archive reports. Inspect and query those models
directly. Complete report disambiguation only if the organizer has also supplied
the full report set; do not claim it was tested from quick setup alone.

1. Search for the issued Zava reports and semantic models.
2. For each **Zava MBR** result, preview its workspace, owner, underlying
   model, reporting period, currency and refresh. Do not pick the first title match.
3. Select Finance for recognized revenue/margin, Commercial for
   bookings/deferral and Operations for fulfillment/freight.
4. Leave the archive report out of current-authority selection. Inspect
   the selected measures, definitions and filters; let Copilot perform the
   supported query rather than writing one yourself.
5. If you use a data agent, check its underlying model route. It is not
   independent confirmation of the same numbers.

```text
Use the exact Finance, Commercial and Operations models for their own
measures. Preserve September 2026, USD and Actual/Budget scope. Inspect
definitions, model instructions and filters before querying. Separate
bookings, deferral and recognized revenue. Reconcile fulfillment and freight
without double counting costs or averaging percentages. Report unavailable
measures and incompatible scope rather than inventing a result.
```

```text
Prepare Zava's September 2026 KPI evidence table in USD. Compare September
Actual with September Budget where supported. Reconcile bookings, recognized
revenue, gross profit/margin, fulfillment and freight. Identify the exact
report/model and measure behind each result, include filters and refresh,
and explain why similarly named reports are not interchangeable.
Keep the output an internal draft; do not alter models or records.
```

**Submit to the judge:** the table, citations and query/result evidence exposed
by your client. Ask it to check model choice, units, scope, reconciliation
and numbers against independently readable evidence.

## Mission 3: Resolve the policy with Foundry IQ

**Business problem:** a current policy and a superseded procedure disagree.
Which one governs the October review, and what evidence or review is needed?

| Creation field | Enter |
|---|---|
| Name | `<your-prefix> Zava Policy Review` |
| Description | Identify current recognition and expedite rules, required evidence and decision roles. |

**Curate Foundry IQ:**

1. Find the issued policy knowledge source. Select it through the lab's
   context picker; participants do not create an index or connect a service.
2. Retrieve and inspect the relevant policy passages and their underlying
   source/version. Prefer current **DOC-03 version 2**, effective October 1,
   for the October review.
3. Inspect superseded **DOC-02** only to explain the conflict. Label it
   historical if you keep it for comparison.
4. Check scope and effective dates. A knowledge-source name alone does not
   establish what the policy says.

```text
Resolve recognition and expedite questions from applicable policy passages.
Check source identity, version, effective date and scope. Distinguish
current DOC-03 from superseded DOC-02 without assuming retroactive effect.
Explain required evidence, review conditions and accountable roles.
Do not treat a sales stage as customer acceptance, a named role as an
assignment, or a policy passage as a recorded approval.
```

```text
For Zava's October review of September 2026, which recognition and expedite
rules apply? Explain the current policy, required evidence, review conditions
and decision roles. Cite the supporting passages and identify what the
superseded procedure cannot establish. Do not approve recognition or spending.
```

**Submit to the judge:** the checklist and policy citations. Ask it to verify
authority, effective date, conditions and roles without supplying an answer key.

<a id="s02-create-and-curate-your-first-business-plugin"></a>
<a id="s03-scope-and-guidance-composition"></a>

## Mission 4: Combine Work, Fabric and Foundry IQ

**Business problem:** Avery does not want three disconnected answers.
Prepare one review that connects decisions, business measures and policy.

| Creation field | Enter |
|---|---|
| Name | `<your-prefix> Zava Monthly Business Review` |
| Description | Prepare a cited internal review of performance, commitments, exceptions and decisions needing human review. |

**Combine the context:**

1. Create a new MBR business plugin rather than overwrite a specialist business plugin.
2. Add the relevant Work references from Mission 1, exact model/report
   references from Mission 2 and policy knowledge from Mission 3.
3. Review the combined selection. Shared references are still one source,
   not three independent confirmations.
4. Add the common guidance and the
   [MBR process guidance](zava-business-plugins.md#monthly-business-review).
   Save and reopen. Check that all three context types and the guidance remain.
5. Use the same business question below in fresh baseline and business plugin
   conversations. Keep account, tools, source versions and access fixed.
   Do not paste a previous answer as a substitute for source evidence.

```text
I am preparing Zava's September 2026 monthly business review for my manager.
Use USD and evidence effective by 2026-10-06T18:00:00Z. Reconcile revenue,
margin, fulfillment and customer commitments. Prepare a cited internal draft,
identify exceptions and missing evidence, and propose role-based next steps.
Do not send, approve, assign, publish or update any business record.
```

After comparing the answers, ask for the deliverable:

```text
Turn the reviewed MBR evidence into a manager-ready internal document:
executive summary, scope/as-of, KPI table with units and source references,
exceptions, conflicting or missing evidence, and proposed next steps.
Keep bookings separate from recognized revenue and hypotheses from proven
causes. Create a Word draft if supported; otherwise provide structured content
and state that no file was created. Do not send, publish or update records.
```

Open any actual file and check its contents. A download link alone does not
prove that the document is correct. An optional private read-only app preview
can use the same evidence if the client supports it; do not deploy or share it.

**Submit to the judge:** the review and its evidence. Ask it to check whether
Work, Fabric and Foundry each support the right claims. Compare evidence
quality with the baseline, not just writing style.

<a id="s04-review-a-curation-proposal"></a>

## Mission 5: Check commitments with Work IQ and Salesforce

**Business problem:** a customer commitment looks promising, but a CRM stage
does not prove delivery, acceptance or recognized revenue.

| Creation field | Enter |
|---|---|
| Name | `<your-prefix> Zava Sales Commitment Review` |
| Description | Prepare an internal commitment-risk handoff from recorded opportunities and workplace evidence. |

**Curate workplace and connector context:**

1. Add the relevant customer-commitment documents and discussions through Work IQ.
2. Find the issued Salesforce connection or its sources in the context picker.
   Preview opportunity identity, stage, amount, currency and period.
3. Select only records relevant to the question. Link a customer/opportunity
   across sources only when the actual identifiers support it.
4. If the connector is unavailable, leave it out and record the missing
   evidence. Do not enable accounts, import records or substitute unrelated data.
5. Add the common guidance and the
   [sales guidance](zava-business-plugins.md#sales-commitment-review).
   Save, reopen and use the business plugin in a fresh Copilot conversation.

```text
Draft Zava's September sales-commitment review from recorded Salesforce
opportunities and workplace commitment evidence. Separate signed business,
open pipeline, proposed follow-up and missing acceptance/delivery evidence.
Cite the source owning each claim and propose a role-based Operations handoff
only where the relationship is supported. Do not promise dates, edit CRM,
assign work or contact customers.
```

**Submit to the judge:** the brief and cited records. Ask it to check actual
stage/amount/currency, customer scope and proposals versus recorded commitments.

## Mission 6: Investigate recovery with IQ and business connectors

**Business problem:** Operations needs to know what the evidence supports,
what is merely proposed and what investigation should happen next.

| Creation field | Enter |
|---|---|
| Name | `<your-prefix> Zava Supply Chain Exception Review` |
| Description | Review fulfillment/freight exceptions, recorded recovery work and evidence needed for next steps. |

**Curate the process context:**

1. Add relevant operating discussions through Work IQ.
2. Select Operations measures through Fabric IQ. Add batch/supplier ontology
   references where relevant; relationships are not proof of cause.
3. Add the applicable policy knowledge through Foundry IQ.
4. Preview the issued Asana recovery records: check completed, assignee and
   due-date fields rather than infer state from descriptions.
5. Add relevant ServiceNow incidents only when available and supported by
   actual record relationships. An incident's priority or timing does not
   establish shipment cause or financial loss.
6. Add the common guidance and the
   [supply-chain guidance](zava-business-plugins.md#supply-chain-exception-review).
   Save and reopen before asking Copilot.

```text
Prepare Zava's September fulfillment/freight exception brief. Reconcile the
Operations evidence, relevant workplace discussion, current policy and
recorded recovery work. Use incident evidence only where the source-owned
relationships support it. Separate findings, causal hypotheses, task state
and proposed investigations. Identify evidence needed for Procurement or
Finance review. Do not assign tasks, change dates, close incidents or spend.
```

**Optional Web IQ extension:** add the current Zava market bulletin.
Ask what it adds to the investigation and what it cannot prove about internal
shipments. Judge this separately from the original attempt using the same rubric.

**Submit to the judge:** the exception brief, model/record evidence and source
citations. Ask it to check missing relationships, task state and unsupported
causal or savings claims.

<a id="s05-draft-a-work-iq-briefing"></a>

## Mission 7: Publish your Zava agent factory

**Business problem:** the teams should reuse your work rather than rebuild
six unrelated prompts every month.

For this exercise, **publish** means save and reopen a reusable catalog in
the existing lab workspace, with its current audience unchanged. It does not
mean deploy autonomous agents or publish to a new audience.

1. Reopen your six process business plugins. Review their descriptions, guidance,
   sources and latest judge feedback. Mark untested processes as needing evidence.
2. Create `<your-prefix> Zava Agent Factory` in the same lab workspace.
   Describe it as a catalog for business review, commitments and recovery.
3. Add the catalog guidance below, replacing brackets with your actual
   saved business plugin names and links where the client exposes them.
4. List each process's business question, owning sources, internal output,
   human reviewer and next process. Use the actual saved references; a typed
   name alone does not create a workflow or bind another business plugin.
5. Save, leave and reopen the catalog. Check the process list and guidance.
6. Demonstrate one two-step handoff: review a Sales Commitment draft, then
   pass its minimal supported evidence to the Supply Chain business plugin in a
   fresh conversation. The next process checks its own sources and identifiers.
   If no operational relationship is supported, stop that route and explain why.
7. Return the reviewed commitment/recovery findings to the MBR process.
   Add any relevant supporting source references to your own MBR business plugin,
   save/reopen and ask for an updated internal review. Keep source versions,
   gaps and provenance visible; the handoff summary is not a replacement for
   the original evidence. Judge this final draft separately from the earlier MBR.

```text
This catalog routes Zava business questions to my saved process business plugins:
Review intent -> [Review Brief].
Performance and measures -> [Performance Review].
Recognition/expedite policy -> [Policy Review].
Leadership synthesis -> [Monthly Business Review].
Customer commitments -> [Sales Commitment Review].
Fulfillment/recovery investigation -> [Supply Chain Exception Review].

For a monthly review: intent -> performance -> policy -> MBR.
For a commitment risk: Sales -> relevant Operations -> policy review -> MBR.
Use only applicable steps. Review each draft before handing it to another
process. Carry scope, cited findings, source identity/version and unresolved
evidence. Each next process independently checks the sources it owns.
Do not double count shared facts, guess record relationships or promote a
proposal to an approval. Stop dependent conclusions when evidence is missing.
Keep outputs internal; do not send, assign, update, spend or deploy.
```

Use the [evidence-brief template](zava-agent-factory.md#the-shared-evidence-handoff-contract)
for the handoff. Ask the judge to review the final two-step draft against the
business request and evidence. Its score does not prove the catalog was saved;
you must reopen and inspect it yourself.

Your factory can grow with
[customer, campaign, checkout, launch and procurement processes](zava-scenarios.md).
Add one process at a time with its own relevant context and reviewed output.

## Safe recovery and troubleshooting

| Problem | Continue safely |
|---|---|
| A source is missing | Save the guidance; mark the mission needs evidence and return later |
| Several results have the same title | Inspect owner, model, scope and freshness before selecting |
| Copilot cannot select the saved business plugin | Ask the instructor; do not claim pasted guidance is service use |
| Guidance or references are missing after reopening | Check the save and ask for help before testing |
| A cover upload fails | Skip the optional cover |
| A citation does not open or support the claim | Retain the gap and revise; do not invent a replacement |
| The judge cannot read the evidence | Get qualitative feedback only; do not record a verified score |
| Document/app creation is unavailable | Keep structured draft content; do not claim a file or app exists |

## Debrief and finish

- [ ] Created and reopened the six process business plugins.
- [ ] Selected Work, Fabric, Foundry and connector context for the questions each owns.
- [ ] Compared at least one unchanged prompt before and after curation.
- [ ] Used judge feedback to improve a business plugin or explained unchanged quality.
- [ ] Reviewed the MBR document and the commitment/recovery drafts.
- [ ] Saved/reopened the factory catalog and demonstrated a relevant handoff.
- [ ] Kept unsupported claims, unavailable sources and untested steps visible.

If sources were unavailable, show the saved guidance and catalog instead of
claiming the missions were verified. You can finish preparation without a
judge score. Tell Avery what the evidence supports,
what still needs investigation and which human should review the next step.
