{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.file."bin/star-rail" = {
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      # 1. Start Honkers (Flatpak) in the background
      flatpak run moe.launcher.the-honkers-railway-launcher &
      launcher_pid=$!

      echo "Waiting for Star Rail to start..."

      # 2. Wait for at least one StarRail.exe process to appear
      while ! pgrep -f 'StarRail.exe' >/dev/null; do
        # If the launcher died before the game started, bail out
        if ! kill -0 "$launcher_pid" 2>/dev/null; then
          echo "Launcher exited before Star Rail started."
          exit 1
        fi
        sleep 1
      done

      echo "Star Rail detected."

      # Optional: small delay to let the window actually show
      sleep 5

      # 3. (Optional) On Hyprland, focus the game window if possible
      if command -v hyprctl >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
        addr=$(hyprctl clients -j | jq -r '.[] | select(.title|test("Star Rail";"i")) | .address' || true)
        if [ -n "${"addr:-"}" ] && [ "$addr" != "null" ]; then
          hyprctl dispatch focuswindow address:"$addr" || true
        fi
      fi

      echo "Star Rail running; waiting for all StarRail.exe processes to exit..."

      # 4. Stay alive as long as ANY StarRail.exe process exists
      while pgrep -f 'StarRail.exe' >/dev/null; do
        sleep 2
      done

      echo "Star Rail exited."

      # 5. When game ends, clean up the launcher if it's still around
      if kill -0 "$launcher_pid" 2>/dev/null; then
        flatpak kill moe.launcher.the-honkers-railway-launcher 2>/dev/null || \
          kill "$launcher_pid" 2>/dev/null || true
      fi

    '';
    executable = true;
  };
}
