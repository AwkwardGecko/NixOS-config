#!/usr/bin/env python3
import json, subprocess
from pathlib import Path

key = json.loads((Path.home() / ".config/Signal/config.json").read_text())["key"]
sql = f"""
PRAGMA key="x'{key}'";
PRAGMA cipher_compatibility = 4;
.schema conversations
"""
result = subprocess.run(
    ["sqlcipher", str(Path.home() / ".config/Signal/sql/db.sqlite")],
    input=sql, capture_output=True, text=True
)
print(result.stdout[:3000])
