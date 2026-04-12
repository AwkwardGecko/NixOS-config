#!/usr/bin/env python3
"""Signal Desktop DB access check."""

import json
import subprocess
import sys
from pathlib import Path

SIGNAL_DIR = Path.home() / ".config" / "Signal"
CONFIG_FILE = SIGNAL_DIR / "config.json"
DB_FILE = SIGNAL_DIR / "sql" / "db.sqlite"

def main():
    errors = []

    # 1. Check paths exist
    print("=== File checks ===")
    for label, path in [("Config", CONFIG_FILE), ("Database", DB_FILE)]:
        exists = path.exists()
        size = path.stat().st_size if exists else 0
        print(f"{label}: {path}")
        print(f"  exists: {exists}, size: {size} bytes")
        if not exists:
            errors.append(f"{label} not found at {path}")

    if errors:
        print("\n".join(errors))
        sys.exit(1)

    # 2. Read encryption key
    print("\n=== Encryption key ===")
    try:
        config = json.loads(CONFIG_FILE.read_text())
        key = config.get("key")
        if not key:
            print("ERROR: 'key' field not found in config.json")
            sys.exit(1)
        print(f"Key found: {key[:8]}...{key[-4:]} (length: {len(key)})")
    except Exception as e:
        print(f"ERROR reading config: {e}")
        sys.exit(1)

    # 3. Check sqlcipher is available
    print("\n=== sqlcipher check ===")
    try:
        result = subprocess.run(["sqlcipher", "--version"], capture_output=True, text=True)
        print(f"sqlcipher version: {result.stdout.strip() or result.stderr.strip()}")
    except FileNotFoundError:
        print("ERROR: sqlcipher not installed")
        print("  Install it with: nix-shell -p sqlcipher")
        print("  Or add 'pkgs.sqlcipher' to your NixOS config")
        sys.exit(1)

    # 4. Try to open and query the database
    print("\n=== Database access ===")
    sql_commands = f"""
PRAGMA key="x'{key}'";
PRAGMA cipher_compatibility = 4;
SELECT count(*) FROM sqlite_master;
"""
    result = subprocess.run(
        ["sqlcipher", str(DB_FILE)],
        input=sql_commands, capture_output=True, text=True
    )

    if "Error" in result.stderr or result.returncode != 0:
        print(f"ERROR: Could not decrypt database")
        print(f"  stderr: {result.stderr.strip()}")
        sys.exit(1)

    table_count = result.stdout.strip()
    print(f"Success! Database has {table_count} tables/indexes")

    # 5. Dump message table schema
    print("\n=== messages table schema ===")
    sql_schema = f"""
PRAGMA key="x'{key}'";
PRAGMA cipher_compatibility = 4;
.schema messages
"""
    result = subprocess.run(
        ["sqlcipher", str(DB_FILE)],
        input=sql_schema, capture_output=True, text=True
    )
    print(result.stdout.strip() if result.stdout.strip() else "Could not retrieve schema")

if __name__ == "__main__":
    main()
