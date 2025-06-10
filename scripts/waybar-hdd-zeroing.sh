#!/usr/bin/env bash

# Grab the last log line with the current progress
latest=$(journalctl -u hdd-zeroing.service | grep '\[zero-wd50ndzw\]' | grep 'Zeroed:' | tail -1)

# Example:
# [zero-wd50ndzw] Zeroed: 1.751 TiB / 4.548 TiB (38%)

# Grab time taken and ETA from last completed chunk
chunk=$(journalctl -u hdd-zeroing.service | grep '\[zero-wd50ndzw\]' | grep 'Chunk complete' | tail -1)

# Parse fields
progress=$(echo "$latest" | grep -oP '\(\K[0-9]+(?=%)')
eta=$(echo "$chunk" | grep -oP 'ETA remaining: \K[^ ]+')
time_taken=$(echo "$chunk" | grep -oP 'Time taken: \K[^ ]+')

# Output JSON
echo "{\"text\": \"🧊 $progress% | ⏳$time_taken | ⏱️$eta\", \"tooltip\": \"Zeroing HDD wd50ndzw\"}"

