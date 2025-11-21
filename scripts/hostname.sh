    set -euo pipefail
    serial=""
    if [ -r /sys/class/dmi/id/product_serial ]; then
      serial=$(tr -d ' \n' </sys/class/dmi/id/product_serial || true)
    fi
    if [ -z "$serial" ] && [ -r /etc/machine-id ]; then
      serial=$(cut -c1-8 /etc/machine-id || true)
    fi
    short=$(printf %s "$serial" | tail -c 6)
    name="dectech-$short"

    current=$(cat /proc/sys/kernel/hostname 2>/dev/null || true)
    if [ "$current" != "$name" ]; then
      /run/current-system/sw/bin/hostname "$name"
    fi
