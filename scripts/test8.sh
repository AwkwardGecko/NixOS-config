#!/usr/bin/env bash
echo "=== SUNSHINE DIAGNOSTICS ==="

echo -e "\n--- Sunshine installation ---"
which sunshine 2>/dev/null || echo "sunshine not in PATH"
command -v sunshine 2>/dev/null || echo "sunshine command not found"
readlink -f "$(which sunshine 2>/dev/null)" 2>/dev/null

echo -e "\n--- Is Sunshine running? As which user? ---"
ps aux | grep -i sunshine | grep -v grep

echo -e "\n--- Sunshine service (systemd) ---"
systemctl --user status sunshine 2>/dev/null | head -20
echo "---"
systemctl status sunshine 2>/dev/null | head -20

echo -e "\n--- NixOS Sunshine config (if declared) ---"
grep -ri "sunshine" ~/.dotfiles/*.nix ~/.dotfiles/**/*.nix 2>/dev/null

echo -e "\n--- Steam location ---"
which steam 2>/dev/null || echo "steam not in PATH"
command -v steam 2>/dev/null || echo "steam command not found"
readlink -f "$(which steam 2>/dev/null)" 2>/dev/null

echo -e "\n--- Current user environment ---"
echo "USER=$USER"
echo "HOME=$HOME"
echo "PATH=$PATH"
echo "WAYLAND_DISPLAY=$WAYLAND_DISPLAY"
echo "XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR"
echo "DISPLAY=$DISPLAY"
echo "DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS"
echo "XDG_SESSION_TYPE=$XDG_SESSION_TYPE"
echo "HYPRLAND_INSTANCE_SIGNATURE=$HYPRLAND_INSTANCE_SIGNATURE"

echo -e "\n--- Sunshine log (last 30 lines) ---"
journalctl --user -u sunshine --no-pager -n 30 2>/dev/null || echo "No user journal for sunshine"
echo "---"
journalctl -u sunshine --no-pager -n 30 2>/dev/null || echo "No system journal for sunshine"

echo -e "\n--- Sunshine config location ---"
ls -la ~/.config/sunshine/ 2>/dev/null
echo "---"
cat ~/.config/sunshine/sunshine.conf 2>/dev/null || echo "No sunshine.conf found"

echo -e "\n--- Wayland sockets ---"
ls -la "$XDG_RUNTIME_DIR"/wayland-* 2>/dev/null || echo "No wayland sockets found in XDG_RUNTIME_DIR"

echo -e "\n--- Can steam launch from this shell? ---"
steam --version 2>/dev/null || echo "steam --version failed"

echo -e "\n=== END DIAGNOSTICS ==="
