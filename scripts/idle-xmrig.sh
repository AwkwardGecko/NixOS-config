#!/usr/bin/env bash

IDLE_LIMIT_MS=$((10 * 60 * 1000)) # 10 minutes
LOW_CPU_CONFIG="/home/zozano/.dotfiles/scripts/xmrig/xmrig-low.json"
HIGH_CPU_CONFIG="/home/zozano/.dotfiles/scripts/xmrig/xmrig-high.json"

while true; do
    idle_time=$(xprintidle)

    if [ "$idle_time" -gt "$IDLE_LIMIT_MS" ]; then
        pkill xmrig
        xmrig -c "$HIGH_CPU_CONFIG" &
    else
        pkill xmrig
        xmrig -c "$LOW_CPU_CONFIG" &
    fi

    sleep 60
done

