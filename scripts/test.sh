#!/usr/bin/env bash
# hyprpanel-idle-diagnostic.sh
# Run this AFTER you've experienced the "hyprpanel didn't reinit" issue.
# Don't restart hyprpanel manually before running it.

set +e
OUT="/tmp/hyprpanel-idle-diag-$(date +%Y%m%d-%H%M%S).txt"
exec > >(tee "$OUT") 2>&1

hr() { printf '\n=== %s ===\n' "$*"; }

hr "Date / uptime / who"
date
uptime
whoami
echo "DISPLAY=$DISPLAY  WAYLAND_DISPLAY=$WAYLAND_DISPLAY  XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR"
echo "HYPRLAND_INSTANCE_SIGNATURE=$HYPRLAND_INSTANCE_SIGNATURE"

hr "Is hyprpanel process actually running?"
pgrep -af hyprpanel || echo "(no hyprpanel process)"

hr "hyprpanel.service status"
systemctl --user status hyprpanel.service --no-pager -l | head -n 40

hr "hyprpanel.service: when did it last (re)start?"
systemctl --user show hyprpanel.service \
  -p ActiveState -p SubState -p Result \
  -p ActiveEnterTimestamp -p ExecMainStartTimestamp -p NRestarts

hr "Last 200 lines of hyprpanel journal"
journalctl --user -u hyprpanel.service -n 200 --no-pager

hr "hyprpanel-hotplug-restart.service status"
systemctl --user status hyprpanel-hotplug-restart.service --no-pager -l | head -n 30

hr "hotplug-restart journal (last 100)"
journalctl --user -u hyprpanel-hotplug-restart.service -n 100 --no-pager

hr "hypridle journal (last 100) — see when DPMS off/on/lock fired"
journalctl --user -u hypridle.service -n 100 --no-pager

hr "Hyprland monitors (current state)"
hyprctl monitors -j 2>/dev/null | head -c 4000
echo

hr "Hyprland workspaces"
hyprctl workspaces 2>/dev/null

hr "Hyprland clients on each monitor (look for hyprpanel layer surfaces)"
hyprctl clients 2>/dev/null | grep -iE 'class:|workspace:|monitor:' | head -n 80

hr "Layer surfaces (hyprpanel lives here)"
hyprctl layers 2>/dev/null | head -n 200

hr "Recent suspend / resume / sleep events (system journal)"
journalctl -b --since "2 hours ago" --no-pager \
  | grep -iE 'suspend|resume|sleep|dpms|hyprlock|hypridle' \
  | tail -n 60

hr "Last 50 lines of Hyprland's own log"
HYPRLOG="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/hyprland.log"
if [[ -f "$HYPRLOG" ]]; then
  tail -n 50 "$HYPRLOG"
else
  echo "(no log at $HYPRLOG; trying glob)"
  ls -la "$XDG_RUNTIME_DIR"/hypr/ 2>/dev/null
fi

hr "Has the .socket2.sock that hotplug-restart watches existed continuously?"
ls -la "$XDG_RUNTIME_DIR"/hypr/*/.socket2.sock 2>/dev/null

hr "DBus session — does the systray host exist?"
busctl --user list 2>/dev/null | grep -iE 'StatusNotifier|kde.StatusNotifier|hyprpanel' || echo "(no matches)"

hr "GTK / GPU env that may matter for hyprpanel rendering"
env | grep -iE 'GTK|GDK|GSK|WLR|NVIDIA|__GL|LIBGL|MESA|XDG_SESSION|XDG_CURRENT' | sort

hr "Done — output saved to: $OUT"
