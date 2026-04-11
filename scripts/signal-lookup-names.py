#!/usr/bin/env python3
import json, subprocess
from pathlib import Path

key = json.loads((Path.home() / ".config/Signal/config.json").read_text())["key"]
sql = f"""
PRAGMA key="x'{key}'";
PRAGMA cipher_compatibility = 4;
.mode column
.headers on
.width 36 20 15 15
SELECT id, profileFullName, type, e164
  FROM conversations
  WHERE type = 'private' AND profileFullName IS NOT NULL AND profileFullName != ''
  ORDER BY active_at DESC;
"""
result = subprocess.run(
    ["sqlcipher", str(Path.home() / ".config/Signal/sql/db.sqlite")],
    input=sql, capture_output=True, text=True
)
for line in result.stdout.strip().splitlines():
    if line and line != "ok":
        print(line)
