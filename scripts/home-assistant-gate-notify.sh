#!/usr/bin/env bash

# Gate open notification — called by Home Assistant via SSH.
# Lives on main PC at ~/.dotfiles/scripts/home-assistant-gate-notify.sh
#
# SSH from HA won't have the Wayland/D-Bus session env,
# so we need to find it from the running user session.

set -euo pipefail

USER_ID=$(id -u)
export XDG_RUNTIME_DIR="/run/user/${USER_ID}"
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"

# Pick up WAYLAND_DISPLAY from Hyprland's environment
WAYLAND_DISPLAY=$(grep -z ^WAYLAND_DISPLAY= /proc/$(pgrep -u "$USER_ID" -x Hyprland | head -1)/environ 2>/dev/null | cut -d= -f2- | tr -d '\0') || true
export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-1}"

notify-send \
    --app-name="Home Assistant" \
    --icon=dialog-information \
    "Gate Opened" \
    "The gate has been opened."
