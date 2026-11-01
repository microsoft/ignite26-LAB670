# Zava: business hats and agent-factory scenarios

[Participant workbook](README.md) | [Curation recipes](zava-business-playbooks.md)

Begin with the Zava MBR journey in the guided workbook, or choose a non-MBR
entry point in the [connected agent-factory journeys](zava-agent-factory.md).
Choose one specialist process during S04; use the remaining processes for
self-paced practice. You can create the playbook and guidance first, then add
business sources and test it when those sources are available.

## One enterprise story

Zava sells equipment and replenishment services. September bookings, recognized revenue, margin, freight and fulfillment need reconciliation. The October review must distinguish current policy from an archive, business-system state from commentary, duplicated evidence from corroboration, and relationships from proven causes.

The analyst begins with a broad MBR. Each exception then becomes a focused process with a different human owner and deliberately selected context. The agent factory reuses these process specifications; it does not give agents unconstrained enterprise write access.

## Persona rotations

The named colleagues are fictional story roles, not accounts to sign in with.
Keep your learner account when changing business hats and use only sources
you can read.

| Scenario / business hat | Request you receive | Relevant context | Draft deliverable / automation boundary |
|---|---|---|---|
| Z01: Business-review analyst supporting Avery Chen, Commercial Director | "Prepare my September MBR; tell me what needs a decision." | Work request/decisions, current policy, exact Finance/Commercial/Operations report-model routes, relevant agent and commitments | Cited MBR Word draft or read-only app draft if supported; no sends or approvals |
| Z02: Jordan Okafor, Operations Lead | "Explain the fulfillment/freight exceptions and which batches need investigation." | Operations report/model, batch/supplier ontology, operating reviews, current market URLs, Asana recovery state | Exception brief and investigation proposals; no causal claims from links, no task edits |
| Z03: Morgan Patel, Finance Controller | "Which recognition conclusions have supporting acceptance evidence?" | Current policy knowledge, full DOC-03, Finance and Commercial measures, Salesforce stage/amount/currency, commitment sources | Acceptance-evidence checklist; no accounting entries or recognition approval |
| Z04: Quinn Garcia, Sales Operations Lead | "Which commitments can we substantiate before a handoff?" | Salesforce opportunity fields, Commercial model, commitment documents and communication policy | Sales risk/handoff draft; no CRM update, promised date or customer message |
| Z05: Taylor Reed, Service Manager | "Which incidents are recorded, and what impact is still only suspected?" | ServiceNow incidents, Operations measures, meeting/incident evidence, relevant task and relationship keys | Triage brief; no closure, customer notification or invented financial impact |
| Z06: Riley Santos, Procurement Lead | "Give me expedite options and their evidence requirements." | Current expedite policy, supplier evidence, Operations model, ontology and recovery-task state | Options brief with proposed role handoffs; no purchase, spend or assignment |
| Z07: Devon Malik, Data Steward | "Why do several Zava MBR reports and policy copies disagree?" | Exact reporting catalog/lineage, model definitions, refresh metadata, current/archived document families | Source-selection map and curation proposal; no model, source or permission changes |

Casey Nguyen, Customer Success Lead, is a referenced collaborator for commitment and service handoffs. Named owners in suggestions remain proposals until the business system records an independently authorized change.

## Hero-scenario pathways

The seven heroes below extend the MBR and specialist processes into Zava's
customer-facing commerce business. Choose a process that interests you.
To test it with Copilot, use its relevant datasets and policies when available.

| Hero / business process | Source routes required by the hero | Draft output |
|---|---|---|
| H01: Customer review from the full account picture | Work, Fabric, Foundry, Web and Salesforce/ServiceNow | Account-review brief: engagement, adoption, support, commitments and public updates |
| H02: Business performance in Zava's own terms | Work and Fabric | The core MBR: revenue/margin by region, reconciled to prior decisions |
| H03: Evidence-based commerce launch recommendation | Work, Fabric, Foundry and Asana/Azure DevOps | Readiness recommendation, uncleared gates and accountable reviewers |
| H04: Public market signals to a campaign decision | Work, Fabric and Web | Up to three campaign options with evidence, assumptions and gaps |
| H05: Measured checkout experience versus external standards | Work, Fabric and Web | Mobile-checkout assessment against approved Web Vitals guidance and release gates |
| H06: Controlling policy and accountable owner | Work and Foundry | Applicable approvals, current authority and final decision owner |
| H07: Checkout incident investigation and operational brief | Work, Fabric, Foundry and ServiceNow/Azure DevOps/Asana | Recorded state, measured impact, related changes and unresolved hypotheses |

Use the sources that answer your question rather than every provider.
For example, H06's controlling-policy question belongs to Work/Foundry;
it does not need a financial-model query.

Each process needs its own evidence: adoption data for customer reviews,
campaign data for campaign decisions, checkout measurements for experience
reviews and controlling policies for launch decisions. The MBR's models and
recognition policy do not answer all of those questions. If a required source
is missing, finish the playbook guidance and return to evidence testing later.

Use the [hero curation recipes](zava-business-playbooks.md#additional-hero-curation-recipes)
for these extensions. Each changes business intent and the minimal source
basket, not the learner's identity, permissions or authority to act.

## Repeat the curation loop for your selected process

1. Read the role's request and define scope, avoid conditions and internal output.
2. Create a separate playbook using your learner prefix in the lab workspace.
3. Preview relevant full sources; resolve exact IDs, report/model lineage, owner, period, units, freshness and source permissions.
4. Exclude irrelevant, duplicate and superseded sources from current-authority selection. Preserve a labelled historical source only when comparison is needed.
5. Add the complete common guidance plus the matching process guidance from the recipes. Keep business answers out of reusable instructions.
6. Review the context and guidance, save, return to the list and reopen.
7. Ask the role's prompt in a new conversation and check the citations and draft.
8. Record missing evidence and what you would need to complete the review.

## Zava's agent-factory catalog

The [integrated factory guide](zava-agent-factory.md) connects the catalog into
three business journeys:

| Journey | Connected processes | Decision draft |
|---|---|---|
| Commitment to revenue assurance | Sales -> Operations -> conditional Procurement -> Finance -> MBR | Substantiated commitments, recovery options and recognition-evidence gaps |
| Market to commerce launch | Campaign -> Checkout + Policy -> Launch -> conditional Customer Review | Readiness recommendation retaining all uncleared gates |
| Incident to customer assurance | Service -> relevant Operations / conditional Procurement -> Sales -> Customer Review; optional MBR | Supported impact and internal customer/recovery brief |

Branches require relevant evidence and verified joins; they are not mandatory
provider calls. The guide supplies Copilot prompts, a common evidence packet,
rules for combining outputs and checks for each handoff. You guide the
handoffs in Copilot rather than automatically deploy a workflow.

Build a catalog and connect at least two processes using the following design
sequence; deployment is not a participant task.

| Stage | What becomes reusable | Human checkpoint |
|---|---|---|
| Intake | Business question, applicability and a user-request trigger | Confirm the request and reporting scope |
| Evidence gathering | Relevant sources, routing, freshness and duplicate-family handling | Resolve ambiguity or missing access |
| Analysis | Explicit measures/filters, reconciliations and evidence limitations | Review unsupported claims and conflicts |
| Artifact drafting | MBR document, exception brief, checklist or read-only app draft if supported | Open and inspect the actual output |
| Handoff | Proposed next steps mapped to human roles | Accept/reject separately; no business-system mutation in this lab |
| Evaluation and maintenance | Prompt, source versions, saved guidance, grounding checks and owner | Revalidate after source/version/permission changes |

Event or scheduled triggers, incident updates, CRM changes, task assignments,
purchases and app deployment are **design proposals only**. They belong to
a separately approved implementation, not this lab.

## Provider coverage through business questions

| Source route | Concrete question it owns | Do not confuse it with |
|---|---|---|
| Work IQ | What did the review request, policy discussion or meeting actually say? | A summary that has not been checked against the original |
| Web IQ | Which publication is current? | Evidence of internal shipment cause |
| Fabric semantic models | Which governed measure answers this scoped KPI question? | A report title, commentary, summed percentages or incompatible filters |
| Fabric data agents | Which selected model/measure route was actually used? | Independent corroboration of the same model data |
| Fabric ontology | Which batch, supplier, period and task keys connect? | Causality, authorization or an additional financial total |
| Foundry IQ | Which retrieved passage/version supports this policy conclusion? | A knowledge-source name without a supporting passage |
| Salesforce / Asana / ServiceNow | What are the recorded opportunity/task/incident fields? | Proposed owners/dates, recognition, proven impact or approval to mutate |

## Finish

Show the role's focused context, saved guidance and internal draft. Explain what
the evidence supports, what is still missing and who should review the proposed
next step. Leave enterprise records unchanged.
