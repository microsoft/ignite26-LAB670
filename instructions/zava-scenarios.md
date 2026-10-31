# Zava Commercial: all-IQ scenario lab

[Session overview](../README.md) | [Zava source walkthrough](zava-commercial.md) | [Skillable setup](../infra/zava/README.md)

This optional lab extends, rather than replaces, Alpine Retail S01-S05.
**Native execution is NOT_RUN.** Work through the scenarios only after your
instructor admits the corresponding provider. A generated artifact, connection,
or completed upload is not proof that an IQ service retrieved it.

## Mission and enterprise context

Zava Commercial supplies commercial equipment and replenishment services.
Leadership is reviewing September 2026 performance in October: bookings look
healthy, but recognized revenue, freight expense, fulfillment and customer
acceptance tell different stories. You prepare a decision brief and reusable
playbook; you do not approve expenditure or update business systems.

The original source pack remains authoritative for the margin-recovery story.
The larger bootstrap corpus adds evidence requests, regional operating reviews,
customer-commitment checks, service incidents and policy discussions. These
supporting records do not invent missing acceptance evidence or prove savings.
All people and records are fictional and explicitly marked synthetic.

| Scenario | Business question | Provider and context | Curation lesson | Completion evidence |
|---|---|---|---|---|
| Z01: Executive handoff | What did leadership request, and what is still unresolved? | Work IQ: Word policies, email archives, meeting transcripts and SharePoint files | Cite full sources; distinguish a recorded discussion from an authorized decision | Full-body reads, source IDs, versions and actual retrieval times |
| Z02: Market freshness | Which external bulletin is current, and does it explain our own shipment performance? | Web IQ: instructor-published synthetic HTTPS pages and URL references | A newer market source supersedes an older bulletin but is not internal causal evidence | Actual URL reads, publication/version fields and separation of internal/external claims |
| Z03: Finance reconciliation | How do bookings, deferrals, recognized revenue, gross profit and freight relate? | Fabric IQ: Finance, Commercial and Operations semantic models | Use explicit measures and identical account, period, currency and scenario filters | Inspected schemas and actual DAX results with model/measure provenance |
| Z04: Analytical routing | Can the data agent select the right governed source? | Three Fabric data-agent drafts over admitted core models | Route to the source owning the sub-question; a second route over the same data is not corroboration | Published agent, actual query trace and comparison with direct model reads |
| Z05: Relationship investigation | Which account, period and supplier connect to a batch and recovery task? | Fabric IQ ontology over managed lakehouse tables | Relationships support investigation, not causal attribution or a new financial total | Bound entity keys, refreshed graph and an actual traversal |
| Z06: Policy authority | Which recognition and expedite guidance applies at the review cutoff? | Three Foundry IQ knowledge bases: policy, operations and commercial commitments | Retrieve passages with source/version/effective date; exclude superseded policy from the current-policy collection | Actual knowledge-base retrieve response and citations; project/index existence alone does not pass |
| Z07: Commercial commitments | What is the recorded opportunity stage, and what is not yet recognized revenue? | Salesforce sandbox or labelled CRM snapshot | Closed Won is a commercial stage, not Finance recognition | Actual sandbox read with stage/amount/currency, or explicitly LOCAL_FIXTURE |
| Z08: Recovery execution | Which actions are recorded, and which owners/dates are only proposals? | Asana sandbox or labelled project snapshot | Task description is not the completed/assignee/due-date fields | Actual task fields; no assignments, comments or completion writes |
| Z09: Service impact | Which service incidents need investigation without overstating financial impact? | ServiceNow sandbox or labelled incident import files | Incident priority/state is not proof of shipment cause, lost revenue or an approved workaround | Actual synthetic incident reads or explicitly LOCAL_FIXTURE |
| Z10: Curated decision desk | Can one reusable playbook coordinate all admitted sources safely? | Microsoft IQ plus admitted Work, Web, Fabric, Foundry and plugin references | Keep mutable answers out of guidance; retain uncertainty and approval boundaries | Save/reopen full guidance, fresh consumption session and observed source/tool trace |

## Personas and account boundary

The bootstrap defines eight fictional roles: Commercial Director, Finance
Controller, Operations Lead, Procurement Lead, Customer Success Lead, Service
Manager, Data Steward and Sales Operations Lead. Source metadata references
stable fictional person keys. The operator maps these keys to **Skillable-issued
accounts** or, with separate approval, creates disabled synthetic Entra users.
Do not infer that fictional authors sent real mail or attended real meetings.

Disabled directory users can support directory lookup; they do not have
mailboxes, Teams history or licenses. Enabling, licensing, password issuance,
group membership and resource grants are separate approved operations. No
learner gets an administrator role through this lab.

## Suggested extension agenda

| Part | Proposed time |
|---|---|
| Read the story, choose admitted providers, confirm source access | 10 minutes |
| Z01-Z02: workplace and web provenance | 15 minutes |
| Z03-Z05: models, agent routing and ontology | 20 minutes |
| Z06-Z09: policy knowledge and third-party records | 20 minutes |
| Z10: curate, save/reopen and compare a fresh response | 15 minutes |

These timings are **unrehearsed** and separate from the core lab. Operator
provisioning and service indexing are not included in learner time.

## Exercise procedure

1. Open the private readiness report issued by your instructor. Select only
   providers marked admitted by actual source-read checks. Do not upload operator
   configuration, test outputs, answer keys or restricted-role fixtures to an agent.
2. Read the complete original Zava source register and the generated manifest.
   Identify authoritative policy, superseded documents, business dates and the
   same-source relationships between copies.
3. In a clean baseline session ask:

   ```text
   Prepare an internal Zava Commercial September 2026 margin-recovery review.
   Cite sources you actually read. Separate bookings from recognized revenue,
   recorded task/incident state from proposals, and market context from internal
   causal evidence. Identify current guidance and unavailable sources.
   Draft only; do not send, invite, approve, assign or change business records.
   ```

4. Review which source/tool routes actually ran. Do not infer retrieval from
   progress narration or an answer mentioning a tool. Record missing evidence
   as unknown.
5. Prepare a playbook proposal with purpose, applicability, exact admitted
   references, freshness/cutoff rules, provider routing, output format and action
   boundaries. Reuse the original guidance proposal without adding numerical
   answers. A URL or model reference does not grant source access.
6. After approval of the native playbook write, save, leave, reopen and read
   every guidance body and reference. Use only supported target-build actions.
7. Run the same baseline prompt in a separate fresh session with the reviewed
   playbook. Hold identity, sources, permissions and model settings constant.
   Compare observed reads, citations, policy handling, uncertainty and action
   safety. Report regressions or no improvement honestly.

**Checkpoint:** Your decision desk cites the sources that own each claim,
preserves current/superseded distinctions, labels unavailable providers, and
contains no consequential action. Local rehearsal does not pass native checks.

## URL, index and transcript distinctions

Local web HTML is not a public page; a public HTTPS page is not necessarily
indexed by Web IQ. Publishing a page requires an approved destination. The
operator records real URLs rather than creating fake citations.

A VTT file uploaded to SharePoint is a transcript **archive**, not a Teams
online-meeting transcript. A calendar appointment does not manufacture a Teams
recording, attendance or transcript history. Outlook drafts are not received
email. The setup guide keeps these lanes separate.

A Search index, knowledge source, knowledge base, Foundry project and
agent connection are distinct resources. Three knowledge bases must be created
and retrieved independently; one index or three folders is not equivalent.

## Finish

Retain only approved redacted evidence in the instructor-issued private
location. Leave source records unchanged. Report each provider independently
as NOT_RUN, BLOCKED, FAIL or PASS. Cleanup is operator-only and needs an exact
resource list and separate approval; do not delete resources by a name prefix.
