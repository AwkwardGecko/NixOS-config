#!/usr/bin/env bash

# Grep the latest sync status from the log
log_file="/steam/Monero/bitmonero.log"  # adjust if needed

# This is super basic. You can expand this to parse percentages etc.
line=$(grep 'Synced' "$log_file" | tail -n 1)
percent=$(echo "$line" | grep -oP '\(\K[0-9]+%' | tr -d '%')

echo "{\"text\": \"XMR: ${percent}%\", \"tooltip\": \"$(echo "$line" | sed 's/"/\\"/g')\"}"

