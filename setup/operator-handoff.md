# Organizer handoff and lab-flow review

## Prepare before the learner clock starts

**Interpretation of the setup-team test:** Zeke reported, "After, I was
immediately able to deploy a fabric capacity with the account after signing
into the fabric portal." This confirms signup unblocked a subsequent capacity
deployment, not that signup created capacity or that the reduced script does so.
The intended new-tenant flow is learner signup, approved automated provisioning,
then context hydration. The current quick script implements only portal opening
and the last stage; capacity/workspace provisioning remains an explicit gap in
the single-script learner experience. Do not describe a fresh tenant as ready
after signup alone.

1. Enroll each new tenant/user through the approved Fabric portal first-sign-in
   process. The setup command opens the portal only; the user reviews and
   accepts terms. No supported automatic signup API is implemented. Do not
   build an unattended Selenium terms-acceptance dependency into the lab.
2. After signup succeeds, provision the approved Azure Fabric capacity through
   the organizer's existing process and assign the issued workspace to it.
   Confirm it is active and supports the lab's features/region. Capacity
   provisioning is not included in the five-to-ten-minute hydration target.
3. If provisioning as **ScoringApp**, have the Fabric administrator verify the
   applicable **Service principals can call Fabric public APIs** tenant setting
   (older UI: **Service principals can use Fabric APIs**) and its allowed
   security-group scope. Grant only the separately approved workspace/resource
   roles. Global Administrator in Entra is not sufficient. If the organizer
   creates workspaces using the principal, check the separate workspace/
   connection/deployment-pipeline setting too. This script creates no workspace
   and changes no tenant settings, groups, consent or role assignments.
4. Prepare one approved SharePoint site/library and an existing Azure AI Search
   service with the API/knowledge-base features used by the original bundle.
   Provide scoped write access for provisioning and separately validate learner
   read access. Fabric/OneLake, Graph, Search data-plane and Azure Resource
   Manager tokens use different audiences/permissions.
5. Fill `tenant.quick.template.json` privately per tenant, including the
   approved usage-cost reference. The principal that runs hydration needs
   access to all these existing targets; do not grant directory-wide admin to
   a learner just to run setup. If those scoped writes are unsuitable for
   learners, execute hydration as the organizer and leave learners sign-in
   plus read-only checks only.
6. Prehydrate/index native M365 sources where the exercise requires mailbox
   or Teams evidence. The quick bundle stages original source documents and
   faithful email archive files to SharePoint; it does not import email or
   manufacture historical meetings. Verify Work IQ can discover the actual
   required citations before releasing the tenant.
7. Bind the real deployed knowledge base to the supported Foundry IQ host
   connection; supply its complete MCP URL/authentication flow. A populated
   Search index/knowledge base alone is not a working learner connection.
8. Keep setup source, private configuration, plans and operator/ledger files
   out of evaluated-agent context. Upload only the explicit `enterprise/`
   allowlist and approved analytical data. The original access DOCX is private,
   contains a password, and is intentionally not copied into this repository.

## Acceptance before distribution

Run the quick Plan/Apply on a fresh isolated tenant and measure wall-clock time
from Apply start through actual learner-source readiness. Record signup,
capacity provisioning and indexing time separately; do not hide them inside
an offline-generation benchmark. Repeat on several fresh Skillable tenants
and check throttling at intended classroom concurrency.

The script records Apply elapsed time and stops starting requests/polls once
the shared 600-second budget is exhausted. It cannot stop an already submitted
Spark job, interrupt an external login/token process or guarantee propagation.
Use the same ledger to reconcile/resume; no new namespace to hide failures.

Verify all three models with real supported queries under the learner account,
including September Actual/Budget scope and preserved units. Verify DOC-03 v2
versus superseded DOC-02 and open the underlying citations. Confirm six
recovery tasks remain incomplete, unassigned and undated. Check actual native
Salesforce/Asana records if Missions 5-6 are enabled. Nothing here is live
validation evidence until those checks have been executed.

## Flow review

Load the numbered learner pages in this order; `instructions/lab-setup.md`
is the index, not an extra exercise:

1. [`instructions/01-github-account.md`](../instructions/01-github-account.md)
2. [`instructions/02-work-iq-setup.md`](../instructions/02-work-iq-setup.md)
3. [`instructions/03-context-hydration.md`](../instructions/03-context-hydration.md)
4. [`instructions/04-playbook-curation.md`](../instructions/04-playbook-curation.md)
5. [`instructions/05-test-playbooks.md`](../instructions/05-test-playbooks.md)

Keep the [mission guide](../instructions/README.md) and
[curation reference](../instructions/zava-business-plugins.md) available during
pages 4-5. Page 5 is reused after each save/reopen, not only after all missions.
Use the supplied [Microsoft IQ home-page URL](https://aka.ms/AA146gyq)
for classroom authoring. No OneDrive download URL is assumed:
use the reviewed setup delivery link actually provided to the class. The
previously distributed ZIP is a snapshot and does not update when these pages
change on GitHub.

| Stage | Recommended learner experience | Remaining dependency / decision |
|---|---|---|
| Client setup | GitHub signup/Outlook verification, then Work IQ skill installation and authentication | Eligible client, writable learner workspace and connector policy must be checked before hydration; do not require Zava evidence yet |
| Context setup | Fabric sign-in/form/terms, then prepared context or approved PowerShell hydration and source checks | First signup is manual; capacity/indexing must be prepared outside the timed core |
| Authoring | Open [Microsoft IQ](https://aka.ms/AA146gyq), then curate/save/reopen each mission's playbook | Preserve Mission 1's pre-creation baseline |
| Mission 1: Work | Find Avery's request, charter and source dates | Work IQ indexing must be independently verified; email archives are not native mail |
| Mission 2: Fabric | Inspect/query the three canonical models | Quick setup omits duplicate/archive reports. Full report-disambiguation exercise needs precreated reports, otherwise use the explicitly documented model-only variation |
| Mission 3: Foundry | Retrieve current/historical policy passages | Quick profile uses one actual MBR KB rather than all three enterprise KB targets; host binding and learner OAuth remain required |
| Mission 4: Combined | Draft the MBR from Work + Fabric + policy evidence | Core numbers, missing acceptance evidence and policy conflict are preserved |
| Mission 5: Commitments | Use the current repo's Work + Salesforce mission | Supplied reference guide describes Asana/Airtable-only plugin scope. Resolve this mismatch before publication; no Airtable schema/data or native SaaS importer was supplied |
| Mission 6: Recovery | Use required sources and preserve original task state | Preprovision the selected connector lane; extra ServiceNow/ADO data is not part of quick hydration |
| Mission 7: Catalog | Save/reopen the process catalog and demonstrate a reviewed handoff | Guidance-only items are not a fully evidence-tested factory |
| Optional journeys | Run only where the corresponding data/connection exists | Expanded customer, campaign, checkout and launch models are intentionally excluded |

**Recommendation:** retain Missions 1-4 as the guaranteed core once source
readiness is proven; make Missions 5-7 conditional on verified connector
readiness, without silently changing their learning objectives. Do not replace
Salesforce with Airtable until the actual table/schema, records and revised
prompts have been agreed. The existing lab remains intact except for explicit
prerequisites, timing and quick-profile caveats.

**Delivery choice:** distribute a reviewed repository ZIP/version or preinstall
it in the VM. Do not ask learners to have Copilot generate provisioning code or
infer tenant resources from an attached bundle. Before hydration, the separate
[GitHub Copilot setup](../instructions/02-work-iq-setup.md)
allows an agent to propose/install reviewed **client skill/configuration files**,
not provision the tenant. Authentication and approval remain with the user.
For web sessions, validate the managed Work IQ connector, organization policy,
learner-owned skill-enabled workspace, actual preview tool availability and
exact saved-playbook discovery before making this the classroom default.
The provided direct OAuth configuration is not a repository-cloud-MCP setup.
The archive also has a `workiq-preview` MCP definition: do not activate that
alongside the separate `Work-IQ-MCP` definition.

References:

- [Fabric developer tenant settings](https://learn.microsoft.com/en-us/fabric/admin/service-admin-portal-developer)
- [Fabric trial limitations](https://learn.microsoft.com/en-us/fabric/fundamentals/fabric-trial)
- [Fabric API quickstart](https://learn.microsoft.com/en-us/rest/api/fabric/articles/get-started/fabric-api-quickstart)
