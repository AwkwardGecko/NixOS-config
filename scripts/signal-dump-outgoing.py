#!/usr/bin/env python3
"""Dump the JSON of recent outgoing messages to inspect read receipt fields."""

import json
import subprocess
import sys
from pathlib import Path

SIGNAL_DIR = Path.home() / ".config" / "Signal"
CONFIG_FILE = SIGNAL_DIR / "config.json"
DB_FILE = SIGNAL_DIR / "sql" / "db.sqlite"

key = json.loads(CONFIG_FILE.read_text())["key"]

sql = f"""
PRAGMA key="x'{key}'";
PRAGMA cipher_compatibility = 4;
SELECT json FROM messages
  WHERE type = 'outgoing'
  ORDER BY sent_at DESC
  LIMIT 1;
"""

result = subprocess.run(
    ["sqlcipher", str(DB_FILE)],
    input=sql, capture_output=True, text=True
)

if result.returncode != 0:
    print(f"Error: {result.stderr.strip()}")
    sys.exit(1)

lines = [l for l in result.stdout.strip().splitlines() if l and l != "ok"]
if not lines:
    print("No outgoing messages found")
    sys.exit(1)

msg = json.loads(lines[0])

# Print a subset of interesting fields
interesting = {}
for k in ["sent_at", "timestamp", "type", "body", "conversationId",
           "sendStateByConversationId", "sendState", "deliveredTo",
           "readBy", "recipients", "unidentifiedDeliveries"]:
    if k in msg:
        interesting[k] = msg[k]

# Also grab any key containing "read", "deliver", "receipt", "state" (case-insensitive)
for k, v in msg.items():
    if any(term in k.lower() for term in ["read", "deliver", "receipt", "state", "status"]):
        interesting[k] = v

print(json.dumps(interesting, indent=2))
