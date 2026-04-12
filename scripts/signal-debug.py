#!/usr/bin/env python3
"""Debug: dump raw rows to check for parsing issues."""

import json, subprocess, time
from pathlib import Path

key = json.loads((Path.home() / ".config/Signal/config.json").read_text())["key"]
db = str(Path.home() / ".config/Signal/sql/db.sqlite")
since = int(time.time() * 1000) - (600 * 1000)  # last 10 min

sql = f"""
PRAGMA key="x'{key}'";
PRAGMA cipher_compatibility = 4;
.separator "%%DELIM%%"
SELECT rowid, sent_at, substr(body, 1, 40), json_extract(json, '$.sendStateByConversationId')
  FROM messages
  WHERE type = 'outgoing' AND sent_at > {since}
  ORDER BY sent_at DESC
  LIMIT 5;
"""

result = subprocess.run(["sqlcipher", db], input=sql, capture_output=True, text=True)
for line in result.stdout.strip().splitlines():
    if line and line != "ok":
        parts = line.split("%%DELIM%%")
        print(f"--- ROW ({len(parts)} parts) ---")
        for i, p in enumerate(parts):
            print(f"  [{i}]: {p[:200]}")
