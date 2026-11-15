"""Small LAB670 plan; canonical evidence is reused, not regenerated or invented."""
from __future__ import annotations

import argparse
import hashlib
import json
import re
import shutil
from email import policy
from email.parser import BytesParser
from pathlib import Path
from urllib.parse import urlparse
from uuid import UUID
from xml.etree import ElementTree as ET

from fabric_artifacts import generate

ROOT = Path(__file__).resolve().parents[2]
CANONICAL = ROOT / "data" / "zava-enterprise"
W = "{http://schemas.openxmlformats.org/wordprocessingml/2006/main}"


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def write_json(path: Path, value: object) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, indent=2, ensure_ascii=True) + "\n", encoding="utf-8")


def document_text(path: Path) -> str:
    import zipfile
    with zipfile.ZipFile(path) as archive:
        document = ET.fromstring(archive.read("word/document.xml"))
    return "\n".join("".join(p.itertext()) for p in document.iter(W + "p"))


def validate(config: dict) -> list[str]:
    if type(config.get("schemaVersion")) is not int or config["schemaVersion"] != 1:
        raise ValueError("Unsupported configuration schema.")
    if config.get("profile") != "LAB670-Quick":
        raise ValueError("Use tenant.quick.template.json; only LAB670-Quick is supported.")
    if config.get("providers") != ["SharePoint", "Fabric", "Search"]:
        raise ValueError("The quick core requires SharePoint, Fabric and Search; no silent partial setup.")
    for key in ("createDisabledPeople", "createOutlookDrafts", "createCalendarAppointments"):
        if config.get(key) is not False:
            raise ValueError(f"{key} must remain JSON false in learner setup.")
    if config.get("mailboxObjectId") is not None:
        raise ValueError("Mailbox writes are not part of quick setup.")
    if config.get("mcp"):
        raise ValueError("Quick setup never changes client connections.")
    if not re.fullmatch(r"[a-z][a-z0-9-]{2,29}", config["resourcePrefix"]):
        raise ValueError("resourcePrefix must be 3-30 lowercase letters, digits or hyphens.")
    blockers = []
    for key in ("tenantId", "tenantDomain", "learnerUpn", "environmentLabel", "costApprovalReference"):
        if not config.get(key):
            blockers.append("Resolve " + key)
    for value, label in ((config["tenantId"], "tenantId"),
                         (config["fabric"]["workspaceId"], "fabric.workspaceId"),
                         (config["fabric"]["capacityId"], "fabric.capacityId")):
        if value is not None and (not isinstance(value, str) or UUID(value).int == 0):
            raise ValueError(label + " must be a nonzero GUID or null.")
    domain = config["tenantDomain"]
    if domain and not re.fullmatch(r"[a-z0-9][a-z0-9.-]*\.[a-z]{2,}", domain):
        raise ValueError("Use a lowercase verified tenant domain.")
    upn = config["learnerUpn"]
    if upn and (not domain or upn.count("@") != 1 or upn.split("@")[1].lower() != domain):
        raise ValueError("learnerUpn must belong to the issued tenant domain.")
    locations = config["sharePoint"]["locations"]
    if len(locations) != 1 or locations[0]["key"] != "mbr":
        raise ValueError("Quick setup uses one existing SharePoint location, key mbr.")
    for key in ("siteId", "driveId"):
        value = locations[0][key]
        if not value:
            blockers.append("Resolve sharePoint.locations[0]." + key)
        elif not isinstance(value, str) or re.search(r"[/\\?#\s]", value):
            raise ValueError("Invalid SharePoint binding: " + key)
    site_url = config["sharePoint"]["siteUrl"]
    if site_url:
        uri = urlparse(site_url)
        if (uri.scheme != "https" or not re.fullmatch(r"[a-z0-9-]+\.sharepoint\.com", uri.netloc)
                or uri.query or uri.fragment):
            raise ValueError("siteUrl must be an approved SharePoint HTTPS URL without credentials.")
    for key in ("workspaceId", "capacityId"):
        if not config["fabric"][key]:
            blockers.append("Resolve fabric." + key)
    for key in ("ontologyAdmitted", "dataAgentAdmitted"):
        if config["fabric"].get(key) is not False:
            raise ValueError("Quick setup excludes ontology and data agents: " + key)
    endpoint = config["search"]["searchEndpoint"]
    if endpoint and not re.fullmatch(r"https://[a-z0-9-]+\.search\.windows\.net/?", endpoint):
        raise ValueError("Use an existing Search HTTPS origin, without credentials or URL parameters.")
    resource = config["search"]["searchResourceId"]
    if resource and not re.fullmatch(
            r"/subscriptions/[0-9a-f-]{36}/resourceGroups/[A-Za-z0-9_.()-]+"
            r"/providers/Microsoft.Search/searchServices/[a-z0-9-]+", resource):
        raise ValueError("Use an exact existing Search ARM resource ID.")
    if endpoint and resource and urlparse(endpoint).hostname != resource.rsplit("/", 1)[1] + ".search.windows.net":
        raise ValueError("Search endpoint and ARM resource do not match.")
    for key in ("searchResourceId", "searchEndpoint"):
        if not config["search"][key]:
            blockers.append("Resolve search." + key)
    if config["search"]["apiVersion"] != "2026-04-01":
        raise ValueError("This bundle uses the inherited Search 2026-04-01 contract.")
    return blockers


def knowledge(output: Path, prefix: str, documents: list[dict]) -> list[dict]:
    name = prefix + "-mbr-index"
    source, kb = prefix + "-mbr-source", prefix + "-mbr-knowledge"
    base = output / "search" / "mbr"
    fields = [{"name": "id", "type": "Edm.String", "key": True, "filterable": True}]
    fields += [{"name": field, "type": "Edm.String", "searchable": True}
               for field in ("title", "content")]
    fields += [{"name": field, "type": "Edm.String", "filterable": True}
               for field in ("sourcePath", "version", "effectiveDate")]
    write_json(base / "index.json", {"name": name, "fields": fields, "semantic": {
        "defaultConfiguration": "zava", "configurations": [{"name": "zava", "prioritizedFields": {
            "titleField": {"fieldName": "title"}, "prioritizedContentFields": [{"fieldName": "content"}],
            "prioritizedKeywordsFields": []}}]}})
    write_json(base / "documents-001.json", {"value": documents})
    write_json(base / "knowledge-source.json", {
        "name": source, "kind": "searchIndex", "description": "LAB670 core review policy evidence",
        "searchIndexParameters": {"searchIndexName": name, "semanticConfigurationName": "zava",
                                 "searchFields": [{"name": "content"}],
                                 "sourceDataFields": [{"name": f} for f in
                                                      ("sourcePath", "version", "effectiveDate", "title")]}})
    write_json(base / "knowledge-base.json", {
        "name": kb, "description": "LAB670 MBR core: current and historical source versions",
        "knowledgeSources": [{"name": source}]})
    return [{"name": name, "sourceName": source, "knowledgeBaseName": kb, "path": "search/mbr",
             "documents": len(documents), "batches": ["search/mbr/documents-001.json"]}]


def build(output: Path, config_path: Path) -> dict:
    output = output.resolve()
    if output.is_relative_to(ROOT.parent.resolve()):
        raise ValueError("Keep generated plans, private config and ledgers outside the lab checkout.")
    if output.exists():
        raise ValueError("Use a NEW output directory; existing evidence is never overwritten.")
    config = json.loads(config_path.read_text(encoding="utf-8-sig"))
    blockers = validate(config)
    original = json.loads((CANONICAL / "manifest.json").read_text(encoding="utf-8"))
    for row in original["files"]:
        path = (CANONICAL / row["path"]).resolve()
        if not path.is_relative_to(CANONICAL.resolve()) or digest(path) != row["sha256"]:
            raise ValueError("Canonical integrity failure: " + row["path"])
    output.mkdir(parents=True)
    shutil.copytree(CANONICAL, output / "canonical")
    uploads, passages = [], []
    for path in sorted((CANONICAL / "work").iterdir()):
        if path.suffix == ".docx":
            relative = "enterprise/mbr/" + path.name
            destination = output / relative
            destination.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(path, destination)
            passages.append({
                "@search.action": "upload", "id": path.stem, "title": path.stem,
                "content": document_text(path), "sourcePath": relative,
                "version": "2" if path.name.startswith("DOC-03-") else "1",
                # Only DOC-03's effective date is established by the source contract.
                "effectiveDate": "2026-10-01" if path.name.startswith("DOC-03-") else None})
        elif path.suffix == ".eml":
            message = BytesParser(policy=policy.default).parsebytes(path.read_bytes())
            body = message.get_body(preferencelist=("plain",))
            if body is None:
                raise ValueError("Canonical email lacks a plain-text body: " + path.name)
            relative = "enterprise/mbr/" + path.stem + "-email-archive.txt"
            destination = output / relative
            destination.parent.mkdir(parents=True, exist_ok=True)
            headers = "\n".join(f"{key}: {message.get(key, '')}" for key in ("From", "To", "Date", "Subject"))
            destination.write_text(
                "Email archive rendition, not a native mailbox message.\n\n" + headers +
                "\n\n" + body.get_content(), encoding="utf-8")
        else:
            raise ValueError("Unexpected core work source: " + path.name)
        uploads.append(relative)
    fabric = generate(output, CANONICAL, core_only=True)
    search = knowledge(output, config["resourcePrefix"], passages)
    write_json(output / "uploads.json", uploads)
    write_json(output / "operator" / "sharepoint-routes.json",
               [{"path": relative, "location": "mbr"} for relative in uploads])
    counts = {"sharePointFiles": len(uploads), "wordDocuments": len(passages), "emailArchives": 8,
              "tables": len(fabric["tables"]), "tableRows": sum(t["rows"] for t in fabric["tables"]),
              "semanticModels": len(fabric["models"]), "notebooks": 1,
              "knowledgeBases": len(search), "indexedPassages": len(passages),
              "newUsers": 0, "dataAgents": 0, "ontologies": 0}
    files = [{"path": p.relative_to(output).as_posix(), "sha256": digest(p), "bytes": p.stat().st_size}
             for p in sorted(output.rglob("*")) if p.is_file()]
    manifest = {"schemaVersion": 1, "profile": "LAB670-Quick", "nativeStatus": "NOT_RUN",
                "counts": counts, "fabric": fabric, "search": search, "files": files}
    write_json(output / "manifest.json", manifest)
    write_json(output / "config.json", config)
    resources = [{"type": kind, "displayName": item["name"], "path": item["path"]}
                 for kind, items in (("SemanticModel", fabric["models"]), ("Notebook", [fabric["notebook"]]))
                 for item in items]
    manual = [
        "User completes first Fabric sign-in and terms in the browser; no automatic signup API.",
        "Organizer provides active capacity, assigned workspace, existing SharePoint library and Search service.",
        "Organizer configures ScoringApp tenant-setting scope and resource roles if service principal is used.",
        "Native email/Teams ingestion and Work IQ indexing are organizer tasks; archives are not mailbox history.",
        "Bind the actual knowledge-base MCP endpoint and verify Foundry retrieval with learner OAuth.",
        "Query each semantic model and open Work IQ citations as the learner; receipts alone are not readiness.",
        "Salesforce/Asana native records, ServiceNow/ADO extensions and Airtable are not imported by this script.",
        "Report lookalikes/archive reports and optional customer/commerce scenarios need organizer prehydration."
    ]
    code = [p for p in Path(__file__).parent.iterdir() if p.suffix in (".py", ".psm1")]
    plan = {
        "schemaVersion": 1, "profile": "LAB670-Quick",
        "status": "DRAFT_UNBOUND" if blockers else "AWAITING_HUMAN_APPROVAL",
        "tenant": config["tenantId"], "blockers": blockers,
        "configSha256": digest(output / "config.json"), "manifestSha256": digest(output / "manifest.json"),
        "sourceHashes": {p.name: digest(p) for p in sorted(code)},
        "entrypointSha256": digest(ROOT / "Setup-LabContext.ps1"),
        "lakehouseName": "ZavaEnterpriseContext", "fabricResources": resources,
        "actions": [
            {"provider": "SharePoint", "target": config["sharePoint"], "files": len(uploads),
             "action": "Create isolated folder; upload only 5 canonical documents and 8 email archive renditions."},
            {"provider": "Fabric", "target": config["fabric"],
             "action": "Create schema-enabled lakehouse, stage 11 original CSVs, run one no-overwrite notebook, create 3 core models."},
            {"provider": "Search", "target": config["search"],
             "action": "Create one index/source/knowledge base, index 5 passages, run one retrieval probe."}],
        "cost": "Existing approved resources only; storage, Spark, Search and queries may incur usage charges.",
        "timing": "5-10 minute warm-environment target, not a verified SLA; portal signup/indexing/capacity creation excluded.",
        "manualOnly": manual,
        "prohibited": ["automated terms acceptance", "capacity creation", "tenant-setting changes", "grants",
                       "user creation", "send", "assign", "delete", "overwrite existing tables"]}
    write_json(output / "plan.json", plan)
    (output / "PLAN.md").write_text(
        "# LAB670 quick context plan\n\nStatus: " + plan["status"] + "\n\n" +
        json.dumps(counts, indent=2) + "\n\nReview every target and action in plan.json before approval.\n\n" +
        "\n".join("- " + item for item in manual) + "\n", encoding="utf-8")
    return manifest


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--config", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    print(json.dumps(build(args.output, args.config)["counts"], indent=2))
