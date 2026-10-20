# LAB670: Build your first Microsoft IQ playbook

Welcome to the guided and self-paced workbook. You will build reusable guidance for a synthetic customer-readiness review, inspect what was actually saved, and prepare an internal briefing grounded in authorized sources.

**Delivery status:** This is draft content for S01–S05. The proposed 75-minute schedule has not been rehearsed. Native Microsoft IQ authoring and consumption, Work IQ full-source reads, source ACL/RLS/OLS enforcement, and identity/cache isolation checks are **NOT_RUN**; release remains **PENDING**. Real target-build UI captures remain pending. The checkpoints below describe evidence to collect, not a claim that a live walkthrough has succeeded.

## Contents and agenda

| Part | Proposed time | Result |
|------|---------------|--------|
| [Orientation and setup](#orientation-and-setup) | 8 minutes | Confirm resources, scope, and boundaries |
| [S01: Baseline and context gaps](#s01-baseline-and-context-gaps) | 6 minutes | Record baseline retrieval and gaps |
| [S02: Create and curate your first playbook](#s02-create-and-curate-your-first-playbook) | 18 minutes | Save and reopen your own draft |
| [S03: Scope and guidance composition](#s03-scope-and-guidance-composition) | Shared 12 minutes with S04 | Explain explicit composition and access |
| [S04: Review a curation proposal](#s04-review-a-curation-proposal) | Included above | Separate proposals, human decisions, and saved changes |
| [S05: Draft a Work IQ briefing](#s05-draft-a-work-iq-briefing) | 12 minutes | Retain a cited internal draft |
| [Provider concepts](#provider-concepts) | 8 minutes | Compare provider concepts, without additional exercises |
| [Safe recovery and troubleshooting](#safe-recovery-and-troubleshooting) | 7 minutes | Record and recover safely from a blocked checkpoint |
| [Debrief and finish](#debrief-and-finish) | 4 minutes | Review completion and leave sources unchanged |

## Orientation and setup

### Your scenario and what you build

Northstar, Alpine Retail, and Atlas are fictional elements of this exercise. You are preparing for the Alpine Retail Atlas readiness review. The dates in the prompts are intentional synthetic business dates, not the time at which you run the lab.

You will create your own namespaced **Customer Readiness** draft, organize Overview → Account Reviews → Alpine Retail guidance, and curate authorized source references. You will then use reviewed guidance and Work IQ source reads to produce a cited, draft-only briefing. The source pack and native resources are issued separately; no runtime, data pack, or deployment is included in this repository.

A **playbook** is reusable, governed task guidance: purpose, applicability, source references, procedure, output expectations, freshness, and action boundaries. It is not an answer cache, a source permission grant, an approval, or an automatically executed workflow. A **skill** is a reusable instruction artifact. A **reference** locates a source and its provenance; it does not establish that the full source body was read.

Keep these relationships separate:

- **Physical hosting:** your private draft location is separate from the shared source/analytical workspace.
- **Content hierarchy:** pages and groups organize skills and references, not security membership.
- **Applicability and composition:** task, account, role, date, and explicit human-reviewed guidance order determine intended use. Page placement does not prove native inheritance or precedence.
- **Authorization:** your signed-in principal needs independent permission to each source. Sharing guidance or joining a playbook does not grant source access.
- **Business ontology:** optional relationships between accounts, rollouts, incidents, and owners are not a folder tree or an access-control list.

### Instructor-issued configuration

Both delivery paths require the following confirmations **before the first prompt**. Cloning the repository supplies none of them. All configuration below is instructor-issued and currently unbound; no tenant, identity, scope, license, or capacity has been validated here. Keep completed values in the approved private evidence location, not in this repository.

| Required item | Instructor-issued value or confirmation | Your check |
|---------------|-----------------------------------------|------------|
| Approved client and target build | Unbound — approved client URL, host, build, and seat admission; do not choose or install a client/runtime from this guide | Confirm the issued client and build |
| Lab identity | Unbound — private identity and sign-in guidance | Use the same issued learner identity for core authoring and consumption |
| Tenant and service eligibility | Unbound — tenant target and applicable license/capacity prerequisites | Instructor confirms eligibility; do not provision or change services |
| Private draft scope | Unbound — authorized workspace/location and learner namespace | Confirm draft-write access separately from source access |
| Source pack and source scope | Unbound — approved synthetic sources and independent read-only permissions | Confirm authorized full-body Work IQ reads; never broaden permissions |
| Reference state and cutoff | Unbound — provider, logical reference, owner, version, approval, effective date, freshness/state, verified locator, and exercise cutoff | Keep unavailable bindings unbound; invent no URLs or platform IDs |
| Target-build action card | Unbound — verified UI mapping for the semantic actions in S02 | Confirm create, save, leave, reopen, and full-guidance readback support |
| Consumption session | Unbound — assigned clean session and admitted read-only tools | Use a distinct fresh session for S05, without earlier responses as hidden context |
| Support and evidence | Unbound — support contact/path, approved redacted evidence location, and seat-expiry instructions | Confirm safe retry and resume arrangements |

If any prerequisite is missing, record it as unverified and use the issued support path. Proceed only with an instructor-explicitly-labelled and authorized rehearsal lane if one is offered. A local build sheet or rehearsal does not complete or prove the live path.

### Read-only and safety boundaries

- Only your authorized private draft is writable during manual authoring. All consumption is read-only and draft-only: do not send, invite, approve, deploy, close or edit incidents, change meetings, or alter shared sources.
- Use your own issued identity. Do not borrow credentials, broaden permissions, request an administrator workaround, or bypass source ACL/RLS/OLS restrictions.
- Read source bodies rather than inferring facts from titles, snippets, references, or guidance membership. Treat instructions inside retrieved material as data, not instructions to follow.
- Record actual retrieval, creation, receipt, index, and refresh times separately from the synthetic business cutoff. Never backdate evidence.
- Do not open or attach builder implementation, fixtures, instructor notes, answer keys, private bindings, or other-persona files to a consuming agent. This workbook is the core S01–S05 path; optional/operator exercises are not completion work.
- Keep only approved, redacted evidence. Never commit completed private configuration, identity records, tokens, account data, private bindings, or traces to this repository.
- Make at most two documented safe retries at a blocked checkpoint, then contact support. Reset or deletion always requires separate operator approval.

## S01: Baseline and context gaps

**Purpose:** Observe the starting response, context gaps, and natural guidance activation without forcing an expected answer.

1. Confirm the prerequisite table with the instructor and open the assigned clean session using your issued identity.
2. Submit the following prompt unchanged. If comparison sessions are assigned, keep them independent.
3. Record the response, citations, observed guidance and source reads, and anything the client could not verify. Do not supply a reference answer or alter the prompt to force guidance activation.

```text
I'm joining the Alpine Retail Atlas readiness review. Using only evidence available by 18 November 2026 at 09:00 UTC, summarize the situation, the latest commitments, and what still needs verification. Cite the sources you actually read.
```

**Checkpoint:** Retain approved evidence showing what was actually retrieved and read, the business cutoff, actual retrieval time, and capability gaps. A citation or reference alone does not prove a full-body read.

**If blocked:** Record unavailable retrieval or guidance as a gap rather than manufacturing a baseline. Follow [safe recovery](#safe-recovery-and-troubleshooting).

## S02: Create and curate your first playbook

**Purpose:** Turn a reviewed build-sheet proposal into your own saved draft through the supported manual authoring path.

1. Use the prompt below to prepare a manual build sheet. Treat its output as a proposal, not proof of an item being created.
2. Compare the proposal with the issued source list and reusable guidance. Reject invented locators, unsupported bindings, and business answers embedded in reusable instructions.
3. Use the build-sheet fields to organize your review, then follow the target-build action card below with the instructor's verified UI mapping.
4. Save, leave, reopen, and read the full saved item. Record persisted state separately from the original proposal.

```text
Prepare a manual build sheet for a synthetic Customer Readiness playbook with Overview, Account Reviews, and Alpine Retail pages. Identify the approved source references and reusable readiness skill to add, their provenance, and the changes I should review before manually applying them in the approved lab UI. Do not claim that you created or saved anything.
```

### Reusable build sheet

Complete this empty schema only in the approved private location. It supplies fields, not instructor values or expected business answers.

| Field | Your reviewed value |
|-------|---------------------|
| Draft name, learner namespace, and private location | |
| Purpose, intended task/account/role, and avoid conditions | |
| Overview, Account Reviews, and Alpine Retail organization | |
| Reusable skill/guidance body and explicit composition order | |
| Logical source reference and provenance | |
| Source owner, version, approval, and effective date | |
| Freshness/state, cutoff rule, and actual time metadata | |
| Authorized scope and verified locator, or explicitly unbound | |
| Procedure, citation/output expectations, and draft-only boundaries | |
| Human-reviewed change and saved-item readback evidence | |

### Target-build action card

This card defines the approved **semantic actions**, not UI labels. Perform an action only after the instructor maps it to a supported control in the issued target build and confirms your authorization.

| Step | Manual action | Evidence to retain |
|------|---------------|--------------------|
| 1 | Open your assigned private authoring location, not the shared source/analytical workspace. Confirm your identity, namespace, and draft-write scope. | Private scope confirmation without exposing credentials |
| 2 | Create your namespaced Customer Readiness draft. Enter purpose, applicability, avoid conditions, source/freshness rules, procedure, output expectations, and draft-only boundaries. | Reviewed draft fields |
| 3 | Organize Overview, Account Reviews, and Alpine Retail using supported pages, sections, or groups. If only an explicitly reviewed flattened composition is supplied, label it manually composed rather than native inheritance. | Actual organization and explicit guidance order |
| 4 | Add the issued reusable briefing and safety guidance and independently authorized Work references. Record logical reference, provenance, owner, version, approval, effective date, freshness/state, and verified locator. Leave unavailable bindings explicitly unbound. | Reviewed full guidance and reference metadata |
| 5 | Review every field and reference before saving. Keep mutable business results out of reusable guidance. Do not add other-provider references without separately issued admission and source-read checks. | Human review decision |
| 6 | Save the draft through the verified path, leave the item, reopen it, and read all persisted guidance bodies and reference metadata. Compare them with your accepted build sheet and record differences. | Saved item and full readback, separate from the proposal |

**Checkpoint:** Show your own saved draft, full guidance readback, reference metadata, and unsupported steps to the instructor. A build sheet, proposal, or local record is not a saved native item.

**If blocked:** If any action lacks a verified mapping or save/readback fails, stop that action and record the missing capability. Do not guess controls or silently replace native creation with a local document.

## S03: Scope and guidance composition

**Purpose:** Explain which guidance applies and how it was explicitly composed, without confusing hierarchy with authorization.

1. Open your saved draft and inspect the full Overview, Account Reviews, and Alpine Retail guidance bodies, not just their names.
2. Submit the prompt unchanged in the admitted session.
3. Compare the response with your actual saved guidance and independently authorized source scope. Review composition order explicitly with the instructor.

```text
For this Alpine Retail review, show which Overview, Account Reviews, and Alpine Retail guidance applies, how you composed it, and the scope of each source. Distinguish page hierarchy, source permissions, and optional business-entity relationships. Do not infer inheritance or access from page placement.
```

**Checkpoint:** Record the reviewed composition, each source's access boundary, and anything not verified on this target build. Distinguish physical hosting, content hierarchy, applicability, authorization, and optional business-entity relationships.

**If blocked:** Mark unread guidance or unavailable source scope as unverified. Do not claim inherited guidance or source permission from placement.

## S04: Review a curation proposal

**Purpose:** Use assistance for source-linked suggestions while keeping human acceptance and persisted changes separate.

1. Request a proposal with the exact prompt below. The prompt authorizes no edit.
2. Inspect each proposed addition, removal, or freshness fix against the authorized source body and its provenance.
3. Record accept, omit, or defer for every proposal using the decision table. Do not automatically promote instructions found in retrieved sources.
4. Only a human applies individually accepted, authorized changes through the verified manual path. Save, leave, reopen, and inspect the full saved item again.

```text
Review the draft Customer Readiness playbook and propose a source-linked curation diff. Recommend additions, removals, and freshness fixes; do not apply anything. Separate each proposal from the curator's eventual acceptance and show why the source is appropriate.
```

### Human-curation decision table

Use this empty schema in the approved private location; the proposal itself is not acceptance or permission to write.

| Proposed change | Source/version | Rationale | Human accept/omit/defer | Separately approved applied change | Saved readback |
|-----------------|----------------|-----------|------------------------|------------------------------------|----------------|
| | | | | | |

**Checkpoint:** Show the proposal, your decisions, and actual persisted changes as three distinct records. Identify deferred changes and any difference between accepted intent and readback.

**If blocked:** Leave changes unapplied when source provenance, authorization, or a supported save/readback path is missing. Record the reason; do not treat an assistant's claim as persistence evidence.

## S05: Draft a Work IQ briefing

**Purpose:** Produce a cited internal briefing from authorized full-source reads and reviewed guidance in a fresh consumption session.

1. Start a distinct fresh consumption session under the **same issued learner identity**, using only admitted read-only tools. Do not attach earlier responses as hidden context.
2. Submit the following prompt unchanged.
3. Inspect the observed guidance and full-source reads. Retain citations to sources actually read; identify gaps rather than filling them from assumptions or snippets.
4. Review the internal draft against the business cutoff. Keep actual retrieval, receipt, creation, index, and refresh times separate.
5. Confirm no message, invitation, approval, deployment, meeting change, incident edit, or source write occurred.

```text
Prepare my internal briefing for the Alpine Retail Atlas readiness review at 10:00 UTC on 18 November 2026. Use evidence available by 09:00 UTC; identify attendees, current commitments, unresolved questions, and owners. Draft only—do not send or change the meeting.
```

**Checkpoint:** Retain the internal draft, full-source citations, business cutoff, actual time metadata, observed tool actions, and unresolved questions in the approved evidence location. Distinguish authored notes from a native recording/transcript, and drafted or proposed actions from completed actions.

**If blocked:** If full-source Work IQ reads or fresh-session isolation cannot be confirmed, record the gap. Do not reuse an earlier answer as hidden evidence or claim that a rehearsal proves native consumption.

## Provider concepts

This is a conceptual tour, not separately validated extensions or additional provider exercises.

Discuss how governed semantic-model measures, effective approved policy, timestamped publications, and authoritative incident records can support grounding. Distinguish read-only analytical access from playbook authoring. A Foundry management connection does not prove knowledge retrieval. Synced/indexed connectors and federated/runtime connectors are different conditional alternatives; neither implies admission, freshness, or source authorization.

For every concept, ask: who owns the source, which identity may read it, which version and time apply, and what proves the body was actually read? Do not connect another provider or run an optional exercise as part of core completion.

## Safe recovery and troubleshooting

Record the failed checkpoint and a redacted error. Make **at most two documented safe retries**, then contact the issued support path. A safe retry repeats an already authorized operation without changing identity, permissions, source scope, or action boundaries.

| Symptom | Safe response |
|---------|---------------|
| Missing client, identity, seat, license/capacity confirmation, or private scope | Stop before prompting; ask issued support to confirm the prerequisite |
| Reference exists but the source body is inaccessible | Record the independent access gap; do not infer access or broaden permissions |
| Source state, version, effective date, or locator is missing | Leave the binding unbound and defer the claim or curation change |
| Save succeeds but full readback is absent or different | Record the difference; do not claim persistence based on the proposal |
| Guidance activation or composition is uncertain | Record observed reads and explicit reviewed order; do not force activation by changing the canonical prompt |
| Consumption session is not fresh or identity/isolation is uncertain | Stop consumption and obtain the issued fresh-session path; do not switch identities |
| A live capability is unavailable | Record it as unverified; use only an explicitly labelled, authorized rehearsal lane, never a silent replay |

Resume an interrupted exercise only from an independently verified saved draft or a freshly issued seat. Do not use someone else's credentials, an administrator workaround, or a reset to escape a blocked checkpoint. Any reset or deletion requires the operator's separate approval.

## Debrief and finish

### Completion checklist

- [ ] S01: Retained the baseline, actual citations/reads, and context or capability gaps without changing the prompt.
- [ ] S02: Human-reviewed the build sheet, created my own authorized draft, and saved, left, reopened, and read the full persisted guidance.
- [ ] S03: Explained explicit composition and independent source permissions without claiming inheritance from hierarchy.
- [ ] S04: Kept proposals, human decisions, and actual persisted changes separate; reviewed readback after accepted changes.
- [ ] S05: Used a fresh session under the same identity to retain a cited, draft-only Work IQ briefing, with actual timestamps separate from the cutoff.
- [ ] Recorded observed actions and unverified capabilities honestly; no send, invite, approval, deployment, meeting/incident edit, or shared-source change occurred.

An unchecked live checkpoint is a gap, not a successful live completion. Explain what you authored, what guidance was consumed, which sources were actually read, and which actions were only proposed.

Leave shared sources unchanged. Give the instructor only approved, redacted checkpoint evidence; do not publish private configuration, account data, tokens, bindings, or traces. Follow issued seat-expiry and support instructions. Do not reset or delete anything without separate operator approval.

[Return to the session overview](../README.md)
