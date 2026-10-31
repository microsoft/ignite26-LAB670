import hashlib
import json
import re
import unittest
import zipfile
from email import policy
from email.parser import BytesParser
from pathlib import Path
from xml.etree import ElementTree as ET

PACK = Path(__file__).resolve().parents[3] / "data" / "zava-commercial"


class SourcePackTests(unittest.TestCase):
    def test_manifest_binds_all_adapted_bytes_and_register_version(self):
        manifest = json.loads((PACK / "manifest.json").read_text(encoding="utf-8"))
        expected = {row["path"] for row in manifest["files"]}
        actual = {
            path.relative_to(PACK).as_posix()
            for path in PACK.rglob("*")
            if path.is_file() and path.name != "manifest.json"
        }
        self.assertEqual(expected, actual)
        for row in manifest["files"]:
            content = (PACK / row["path"]).read_bytes()
            with self.subTest(source=row["path"]):
                self.assertEqual(row["bytes"], len(content))
                self.assertEqual(row["sha256"], hashlib.sha256(content).hexdigest())
        plan = (PACK / "tenant-action-plan.json").read_bytes()
        self.assertEqual(manifest["tenant_plan_sha256"], hashlib.sha256(plan).hexdigest())
        register = json.loads((PACK / "source-register.json").read_text(encoding="utf-8"))
        self.assertEqual(manifest["scenario"], register["scenario"])

    def test_zava_only_business_labels_include_word_and_decoded_mail(self):
        forbidden = re.compile(
            r"Zava\s+Commercial|Northstar|Alpine\s+Retail|\bAtlas\b|"
            r"Cedar\s+Bridge|Pine\s+Grove|Maple\s+Works|"
            r"Harbor\s+Components|Summit\s+Packaging", re.I
        )
        for path in PACK.rglob("*"):
            if not path.is_file():
                continue
            if path.suffix == ".docx":
                with zipfile.ZipFile(path) as archive:
                    text = "\n".join(
                        "".join(ET.fromstring(archive.read(name)).itertext())
                        for name in archive.namelist() if name.endswith(".xml")
                    )
            elif path.suffix == ".eml":
                message = BytesParser(policy=policy.default).parsebytes(path.read_bytes())
                body = message.get_body(preferencelist=("plain",))
                self.assertIsNotNone(body)
                text = "\n".join(str(value) for _, value in message.items())
                text += "\n" + body.get_content()
            else:
                text = path.read_text(encoding="utf-8")
            with self.subTest(source=path.relative_to(PACK)):
                self.assertIsNone(forbidden.search(text))


if __name__ == "__main__":
    unittest.main()
