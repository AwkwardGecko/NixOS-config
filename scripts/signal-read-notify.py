#!/usr/bin/env python3
"""Signal Desktop read receipt notifier.

Polls the Signal SQLite database for outgoing messages whose
sendState flips to "Read" and sends a desktop notification.
"""

import json
import subprocess
import time
import sys
from pathlib import Path

SIGNAL_DIR = Path.home() / ".config" / "Signal"
CONFIG_FILE = SIGNAL_DIR / "config.json"
DB_FILE = SIGNAL_DIR / "sql" / "db.sqlite"
POLL_INTERVAL = 3  # seconds
# Only track messages from the last N seconds on startup
STARTUP_WINDOW = 300  # 5 minutes


def get_key():
    return json.loads(CONFIG_FILE.read_text())["key"]


def query_db(key, sql):
    full_sql = f"PRAGMA key=\"x'{key}'\";\nPRAGMA cipher_compatibility = 4;\n{sql}"
    result = subprocess.run(
        ["sqlcipher", str(DB_FILE)],
        input=full_sql, capture_output=True, text=True
    )
    if result.returncode != 0:
        print(f"DB error: {result.stderr.strip()}", file=sys.stderr)
        return []
    lines = [l for l in result.stdout.strip().splitlines() if l and l != "ok"]
    return lines


def get_contact_names(key):
    """Build a map of conversation UUID -> display name."""
    rows = query_db(key, """
        SELECT id, profileFullName, profileName, e164
        FROM conversations
        WHERE type = 'private';
    """)
    names = {}
    for row in rows:
        parts = row.split("|")
        if len(parts) >= 4:
            uuid = parts[0]
            name = parts[1] or parts[2] or parts[3] or uuid
            names[uuid] = name
    return names


def get_outgoing_messages(key, since_ts):
    """Fetch recent outgoing messages with their send state."""
    rows = query_db(key, f"""
        SELECT rowid, sent_at, body, json_extract(json, '$.sendStateByConversationId')
        FROM messages
        WHERE type = 'outgoing' AND sent_at > {since_ts}
        ORDER BY sent_at DESC
        LIMIT 100;
    """)
    messages = []
    for row in rows:
        parts = row.split("|", 3)
        if len(parts) < 4:
            continue
        rowid = parts[0]
        sent_at = parts[1]
        body = parts[2] or ""
        try:
            send_state = json.loads(parts[3]) if parts[3] else {}
        except json.JSONDecodeError:
            send_state = {}
        messages.append({
            "rowid": rowid,
            "sent_at": sent_at,
            "body": body[:80],
            "send_state": send_state,
        })
    return messages


def notify(summary, body=""):
    subprocess.run([
        "notify-send",
        "--app-name=Signal",
        "--icon=signal-desktop",
        summary,
        body,
    ])


def main():
    if not CONFIG_FILE.exists() or not DB_FILE.exists():
        print("Signal Desktop config/database not found.", file=sys.stderr)
        sys.exit(1)

    key = get_key()
    contacts = get_contact_names(key)

    # Track which (rowid, conversation_id) pairs we've already seen as "Read"
    seen_read = set()

    # Only look at messages from the last STARTUP_WINDOW seconds
    startup_ts = int(time.time() * 1000) - (STARTUP_WINDOW * 1000)

    # Seed seen_read with anything already "Read" so we don't spam on startup
    messages = get_outgoing_messages(key, startup_ts)
    for msg in messages:
        for conv_id, state in msg["send_state"].items():
            if state.get("status") == "Read":
                seen_read.add((msg["rowid"], conv_id))

    print(f"Monitoring read receipts (tracking {len(seen_read)} already-read states)...")

    while True:
        time.sleep(POLL_INTERVAL)

        try:
            messages = get_outgoing_messages(key, startup_ts)
        except Exception as e:
            print(f"Poll error: {e}", file=sys.stderr)
            continue

        for msg in messages:
            for conv_id, state in msg["send_state"].items():
                if state.get("status") == "Read":
                    pair = (msg["rowid"], conv_id)
                    if pair not in seen_read:
                        seen_read.add(pair)
                        name = contacts.get(conv_id, conv_id)
                        body_preview = msg["body"] if msg["body"] else "(no text)"
                        notify(
                            f"{name} read your message",
                            body_preview,
                        )
                        print(f"[READ] {name}: {body_preview}")

        # Refresh contacts occasionally (handles new conversations)
        contacts = get_contact_names(key)


if __name__ == "__main__":
    main()
