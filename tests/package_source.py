"""Create a source-only ZIP with an explicit allowlist; no Git metadata or caches."""
from pathlib import Path
import hashlib
import json
import sys
import zipfile

root = Path(__file__).resolve().parents[1]
destination = Path(sys.argv[1]).resolve()
if destination.exists():
    raise SystemExit("Refusing to overwrite an existing immutable candidate")
top = {"README.md", "CLAUDE.md", "LICENSE", "CONTRIBUTING.md", "CODE_OF_CONDUCT.md",
       "SECURITY.md", "CHANGELOG.md", ".gitattributes", ".gitignore"}
folders = {"scripts", "docs", "templates", "tests", "images", ".github"}
suffixes = {".md", ".ps1", ".sh", ".json", ".py", ".yml", ".yaml"}
files = [p for p in root.rglob("*") if p.is_file() and not p.is_symlink()
         and (p.relative_to(root).parts[0] in folders or p.relative_to(root).as_posix() in top)
         and (p.suffix in suffixes or p.name in top)
         and "__pycache__" not in p.parts
         and not any(part.startswith(".env") for part in p.relative_to(root).parts)
         and not any(parent.is_symlink() for parent in p.parents if parent != root)]
manifest = {"baseline": "8b5575bff5f6cd3f0f964df54010233d9b04c010",
            "files": {p.relative_to(root).as_posix(): hashlib.sha256(p.read_bytes()).hexdigest()
                      for p in sorted(files)}}
with zipfile.ZipFile(destination, "x", compression=zipfile.ZIP_DEFLATED) as archive:
    for path in sorted(files):
        archive.write(path, "claude-code-essentials/" + path.relative_to(root).as_posix())
    archive.writestr("claude-code-essentials/SOURCE-MANIFEST.json", json.dumps(manifest, indent=2) + "\n")
print(str(destination))
print("Source files:", len(files))
