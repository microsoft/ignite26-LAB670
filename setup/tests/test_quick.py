import ast
import base64
import copy
import csv
import json
import sys
import tempfile
import types
import unittest
from pathlib import Path
from unittest.mock import MagicMock, patch

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "infra" / "zava"))
import build_quick as quick


class QuickSetupTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.home = Path(self.temp.name)
        self.config = json.loads((ROOT / "tenant.quick.template.json").read_text())

    def build(self, name="run"):
        config_path = self.home / "tenant.json"
        quick.write_json(config_path, self.config)
        output = self.home / name
        manifest = quick.build(output, config_path)
        return output, manifest

    def test_exact_small_core_and_original_evidence(self):
        output, manifest = self.build()
        self.assertEqual(manifest["counts"]["sharePointFiles"], 13)
        self.assertEqual(manifest["counts"]["tables"], 11)
        self.assertEqual(manifest["counts"]["semanticModels"], 3)
        self.assertEqual(manifest["counts"]["indexedPassages"], 5)
        self.assertEqual(len(list((output / "fabric").rglob("*.json"))), 4)
        self.assertEqual(manifest["fabric"]["agents"], [])
        self.assertIsNone(manifest["fabric"]["ontology"])
        for path in quick.CANONICAL.rglob("*"):
            if path.is_file():
                self.assertEqual(path.read_bytes(), (output / "canonical" / path.relative_to(quick.CANONICAL)).read_bytes())
        uploads = json.loads((output / "uploads.json").read_text())
        self.assertEqual(len(uploads), len(set(uploads)))
        self.assertFalse(any("operator" in p or "canonical" in p for p in uploads))
        for path in uploads:
            self.assertTrue((output / path).is_file())
        for row in manifest["files"]:
            self.assertEqual(row["sha256"], quick.digest(output / row["path"]))
        with (output / "canonical" / "fabric" / "recovery_tasks.csv").open(newline="") as handle:
            tasks = list(csv.DictReader(handle))
        self.assertEqual(len(tasks), 6)
        self.assertTrue(all(r["Completed"].lower() == "false" and not r["AssigneeKey"] and not r["DueOn"] for r in tasks))
        with (output / "canonical" / "fabric" / "finance.csv").open(newline="") as handle:
            finance = list(csv.DictReader(handle))
        self.assertEqual(sum(int(r["RevenueUSD"]) for r in finance if r["PeriodKey"] == "202609" and r["Scenario"] == "Actual"), 12_000_000)

    def test_policy_versions_citation_routes_and_compact_notebook(self):
        output, manifest = self.build()
        docs = json.loads((output / "search" / "mbr" / "documents-001.json").read_text())["value"]
        current = next(r for r in docs if r["id"].startswith("DOC-03"))
        historical = next(r for r in docs if r["id"].startswith("DOC-02"))
        self.assertEqual((current["version"], current["effectiveDate"]), ("2", "2026-10-01"))
        self.assertIsNone(historical["effectiveDate"])
        self.assertIn("superseded", historical["id"])
        routes = json.loads((output / "operator" / "sharepoint-routes.json").read_text())
        self.assertTrue(all(any(r["path"] == d["sourcePath"] for r in routes) for d in docs))
        notebook = json.loads((output / manifest["fabric"]["notebook"]["path"]).read_text())
        content = json.loads(base64.b64decode(notebook["definition"]["parts"][0]["payload"]))
        code = "".join(content["cells"][0]["source"])
        ast.parse(code)
        self.assertIn("COMPACT_VALIDATION = True", code)
        self.assertIn('mode("errorifexists")', code)
        self.assertIn('df.agg(*checks)', code)

    def test_plan_is_bound_deterministic_and_unresolved_template_cannot_apply(self):
        first, _ = self.build("one")
        second, _ = self.build("two")
        self.assertEqual((first / "plan.json").read_bytes(), (second / "plan.json").read_bytes())
        plan = json.loads((first / "plan.json").read_text())
        self.assertEqual(plan["status"], "DRAFT_UNBOUND")
        self.assertTrue(plan["blockers"])
        self.assertEqual(plan["entrypointSha256"], quick.digest(ROOT / "Setup-LabContext.ps1"))
        for name, value in plan["sourceHashes"].items():
            self.assertEqual(value, quick.digest(ROOT / "infra" / "zava" / name))
        self.assertEqual(plan["manifestSha256"], quick.digest(first / "manifest.json"))
        self.assertEqual(plan["configSha256"], quick.digest(first / "config.json"))

    def test_compact_validation_rejects_bad_rows_or_required_nulls_before_writes(self):
        output, manifest = self.build()
        body = json.loads((output / manifest["fabric"]["notebook"]["path"]).read_text())
        notebook = json.loads(base64.b64decode(body["definition"]["parts"][0]["payload"]))
        code = "".join(notebook["cells"][0]["source"])
        type_module = types.ModuleType("pyspark.sql.types")
        for name in ("StringType", "LongType", "DateType", "BooleanType", "StructType", "StructField"):
            setattr(type_module, name, MagicMock())
        sql_module = types.ModuleType("pyspark.sql")
        sql_module.functions = MagicMock()
        modules = {"pyspark": types.ModuleType("pyspark"), "pyspark.sql": sql_module,
                   "pyspark.sql.types": type_module}
        original = (quick.CANONICAL / "fabric" / "accounts.csv").read_bytes()
        for stats, error in (({"_rows": 2, "_null_AccountKey": 0, "_null_AccountName": 0}, "row count"),
                             ({"_rows": 1, "_null_AccountKey": 1, "_null_AccountName": 0}, "Required value is null")):
            with self.subTest(stats=stats):
                spark, df = MagicMock(), MagicMock()
                df.cache.return_value = df
                df.agg.return_value.first.return_value.asDict.return_value = stats
                reader = spark.read.format.return_value
                reader.option.return_value = reader
                reader.schema.return_value = reader
                reader.load.return_value = df
                with patch.dict("sys.modules", modules), patch.object(Path, "read_bytes", return_value=original):
                    with self.assertRaisesRegex(ValueError, error):
                        exec(compile(code, "<quick-notebook>", "exec"), {"spark": spark})
                df.write.format.assert_not_called()
                spark.sql.assert_not_called()
                df.unpersist.assert_called_once()

    def test_unsafe_or_partial_configuration_is_rejected(self):
        cases = []
        for key in ("createDisabledPeople", "createOutlookDrafts", "createCalendarAppointments"):
            for value in (True, "false", 0):
                config = copy.deepcopy(self.config)
                config[key] = value
                cases.append(config)
        config = copy.deepcopy(self.config)
        config["providers"] = ["Fabric"]
        cases.append(config)
        config = copy.deepcopy(self.config)
        config["search"]["searchEndpoint"] = "https://example.search.windows.net/?token=secret"
        cases.append(config)
        config = copy.deepcopy(self.config)
        config["fabric"]["workspaceId"] = "not-a-guid"
        cases.append(config)
        config = copy.deepcopy(self.config)
        config["sharePoint"]["locations"][0]["driveId"] = "../other"
        cases.append(config)
        for config in cases:
            with self.subTest(config=config):
                with self.assertRaises((ValueError, TypeError)):
                    quick.validate(config)

    def test_existing_output_and_corrupt_canonical_are_rejected(self):
        self.build()
        with self.assertRaisesRegex(ValueError, "NEW output"):
            self.build()
        fixture = self.home / "fixture"
        import shutil
        shutil.copytree(quick.CANONICAL, fixture)
        (fixture / "fabric" / "finance.csv").write_text("corrupt")
        with patch.object(quick, "CANONICAL", fixture):
            with self.assertRaisesRegex(ValueError, "integrity"):
                self.build("corrupt")
        self.assertFalse((self.home / "corrupt").exists())


if __name__ == "__main__":
    unittest.main()
