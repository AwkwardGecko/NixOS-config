#!/usr/bin/env bash

log_file="/steam/Monero/bitmonero.log"

line=$(grep 'Synced' "$log_file" | tail -n 1)
percent=$(echo "$line" | sed -n 's/.*(\([0-9]\+\)%,.*/\1/p')

# Escape double quotes for tooltip
escaped_line=$(echo "$line" | sed 's/"/\\"/g')

echo "{\"text\": \"XMR: ${percent}%\", \"tooltip\": \"${escaped_line}\"}"

if [[ -z "$percent" ]]; then
    echo '{"text": "XMR: ?", "tooltip": "No sync data found"}'
    exit 0
fi

