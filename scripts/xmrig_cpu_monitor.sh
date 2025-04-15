#!/usr/bin/env bash

CPU_THRESHOLD=20  # Define the CPU usage threshold (in percentage)

# Get current CPU usage (using `mpstat` or `top`, etc.)
CPU_USAGE=$(mpstat 1 1 | tail -n 1 | awk '{print 100 - $12}')

# Start or stop xmrig based on the CPU usage
if (( $(echo "$CPU_USAGE < $CPU_THRESHOLD" | bc -l) )); then
    if ! pgrep -x "xmrig" > /dev/null; then
        echo "CPU usage below threshold. Starting xmrig..."
        systemctl start xmrig
    fi
else
    if pgrep -x "xmrig" > /dev/null; then
        echo "CPU usage above threshold. Stopping xmrig..."
        systemctl stop xmrig
    fi
fi

