#!/usr/bin/env bash
set -euo pipefail

serial=""

if [ -r /sys/class/dmi/id/product_serial ]; then
  serial=$(tr -d ' \n' </sys/class/dmi/id/product_serial) || serial=""
fi

if [ -z "$serial" ] && [ -r /etc/machine-id ]; then
  serial=$(cut -c1-8 /etc/machine-id) || serial=""
fi

short=""
if [ -n "$serial" ]; then
  short=$(printf %s "$serial" | tail -c 6)
fi

name="dectech-$short"
current=$(cat /proc/sys/kernel/hostname 2>/dev/null || true)

if [ "$current" != "$name" ]; then
  /run/current-system/sw/bin/hostname "$name"
fi

