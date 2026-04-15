#!/usr/bin/env python3
"""Signal Desktop read receipt notifier.

Polls the Signal SQLite database for outgoing messages whose
sendState flips to "Read" and sends a desktop notification.
Also tails Signal logs for incoming typing indicators.
"""

import json
import subprocess
import time
import sys
import threading
import glob
import os
from pathlib import Path

SIGNAL_DIR = Path.home() / ".config" / "Signal"
CONFIG_FILE = SIGNAL_DIR / "config.json"
DB_FILE = SIGNAL_DIR / "sql" / "db.sqlite"
LOG_DIR = SIGNAL_DIR / "logs"
POLL_INTERVAL = 3  # seconds
STARTUP_WINDOW = 300  # 5 minutes

PRIORITY_CONTACTS = {
    #"ef7a4dae-bc1c-4e0c-95f0-5fa884dbb9ae",  # emily
    #"a0b172d9-2878-4896-8aa2-ade5555dd714",  # jason
    #"7672d921-c5f3-48d9-9ecc-8890427c4f63",  # andrew
    #"016f0bdf-141d-4012-aa1d-e983e253379d",  # seulgee
    #"daba8ea9-3759-484f-be14-0761cb7b889e",  # jenny luck
    #"427d9baf-1be2-4675-b136-a4208c1f3017",  # ash wrightson
    #"81407814-0d47-4369-9334-ff362b2cb8ec",  # ranon
    #"62f94418-58ae-4174-b3c3-cb18b542df81",  # rex
    #"a0c6f39c-154f-4ba1-a8dd-54cdec6f4b6b",  # mum
    #"b5e152f6-b535-41f6-9c3c-4e3f35d5183a",  # dad
    #"d79a939d-b8b0-46db-8613-5894b0fdd5e2",  # glenn
    #"5ec5150a-0b82-435e-8e0a-b9a01d652212",  # ash keogh
    #"6ee23076-d800-4963-8292-3229bf5d3ce9",  # yejin
}

ALERT_SOUND = "/home/zozano/.dotfiles/modules/other/signal-notification-sound.wav"


def get_key():
    return json.loads(CONFIG_FILE.read_text())["key"]


def query_db(key, sql):
    full_sql = f"PRAGMA key=\"x'{key}'\";\nPRAGMA cipher_compatibility = 4;\n{sql}"
    result = subprocess.run(
        ["sqlcipher", str(DB_FILE)],
        input=full_sql, capture_output=True, text=True,
    )
    if result.returncode != 0:
        print(f"DB error: {result.stderr.strip()}", file=sys.stderr)
        return []
    lines = [l for l in result.stdout.strip().splitlines() if l and l != "ok"]
    return lines


def get_contact_names(key):
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


def get_service_id_to_conv_id(key):
    """Map serviceId (the redacted IDs in logs) to conversation id."""
    rows = query_db(key, """
        SELECT id, serviceId
        FROM conversations
        WHERE type = 'private' AND serviceId IS NOT NULL;
    """)
    mapping = {}
    for row in rows:
        parts = row.split("|")
        if len(parts) >= 2:
            mapping[parts[1]] = parts[0]
    return mapping


def get_outgoing_messages(key, since_ts):
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


def notify(summary, body="", priority=False):
    urgency = "critical" if priority else "normal"
    subprocess.run([
        "notify-send",
        "--app-name=Signal",
        "--icon=signal-desktop",
        f"--urgency={urgency}",
        summary,
        body,
    ])
    if priority:
        subprocess.Popen(
            ["mpv", "--no-video", ALERT_SOUND],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )


def get_latest_log():
    logs = sorted(glob.glob(str(LOG_DIR / "*.log")), key=os.path.getmtime)
    return logs[-1] if logs else None


def tail_log_for_typing(contacts):
    """Tail Signal's log file watching for incoming typing indicators."""
    last_typing_notify = {}
    TYPING_COOLDOWN = 30  # seconds between typing notifications per contact

    log_path = get_latest_log()
    if not log_path:
        print("No Signal log file found, typing detection disabled.", file=sys.stderr)
        return

    print(f"Tailing {log_path} for typing indicators...")

    with open(log_path, "r") as f:
        # Seek to end
        f.seek(0, 2)

        while True:
            line = f.readline()
            if not line:
                new_log = get_latest_log()
                if new_log and new_log != log_path:
                    print(f"Log rotated to {new_log}")
                    log_path = new_log
                    f.close()
                    f = open(log_path, "r")
                    f.seek(0, 2)
                time.sleep(0.5)
                continue

            if "typing" not in line.lower():
                continue

            try:
                entry = json.loads(line)
                msg = entry.get("msg", "")

                # We want INCOMING typing, not our own outgoing
                if "typingMessage" in msg and "sending" not in msg.lower():
                    now = time.time()
                    for service_id, conv_id in service_id_map.items():
                        if service_id in msg or conv_id in msg:
                            name = contacts.get(conv_id, conv_id)
                            last = last_typing_notify.get(conv_id, 0)
                            if now - last > TYPING_COOLDOWN:
                                last_typing_notify[conv_id] = now
                                priority = conv_id in PRIORITY_CONTACTS
                                notify(
                                    f"[typing] {name}",
                                    "is typing...",
                                    priority=priority,
                                )
                                print(f"[TYPING] {name}")
                            break
            except (json.JSONDecodeError, KeyError):
                continue


# Globals for cross-thread access
service_id_map = {}


def main():
    global service_id_map

    if not CONFIG_FILE.exists() or not DB_FILE.exists():
        print("Signal Desktop config/database not found.", file=sys.stderr)
        sys.exit(1)

    key = get_key()
    contacts = get_contact_names(key)
    service_id_map = get_service_id_to_conv_id(key)

    # Start typing indicator watcher in background thread
    typing_thread = threading.Thread(
        target=tail_log_for_typing, args=(contacts,), daemon=True
    )
    typing_thread.start()

    # Track (rowid, conv_id) -> updatedAt timestamp
    # This catches re-reads after edits (updatedAt changes)
    seen_read = {}

    startup_ts = int(time.time() * 1000) - (STARTUP_WINDOW * 1000)

    # Seed with existing read states
    messages = get_outgoing_messages(key, startup_ts)
    for msg in messages:
        for conv_id, state in msg["send_state"].items():
            if state.get("status") == "Read":
                pair = (msg["rowid"], conv_id)
                seen_read[pair] = state.get("updatedAt", 0)

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
                    updated_at = state.get("updatedAt", 0)

                    # Notify if never seen, or if updatedAt changed (re-read after edit)
                    if pair not in seen_read or seen_read[pair] != updated_at:
                        was_reread = pair in seen_read
                        seen_read[pair] = updated_at
                        name = contacts.get(conv_id, conv_id)
                        body_preview = msg["body"] if msg["body"] else "(no text)"
                        priority = conv_id in PRIORITY_CONTACTS
                        tag = "[re-read]" if was_reread else "[read]"
                        notify(
                            f"{tag} {name}",
                            body_preview,
                            priority=priority,
                        )
                        print(f"{tag.upper()} {name}: {body_preview}")

        contacts = get_contact_names(key)
        service_id_map = get_service_id_to_conv_id(key)


if __name__ == "__main__":
    main()
