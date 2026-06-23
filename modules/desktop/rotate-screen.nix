# ~/.dotfiles/modules/rotate-screen.nix
{...}: {
  home-manager.users.zozano.home.file.".local/bin/scripts/rotate-screen.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      # Get the focused monitor's name and current transform
      read -r MON CUR < <(
        hyprctl -j monitors \
          | jq -r '.[] | select(.focused == true) | "\(.name) \(.transform)"'
      )

      if [[ -z "''${MON:-}" ]]; then
        echo "rotate-screen: could not determine focused monitor" >&2
        exit 1
      fi

      # Cycle normal -> 90 -> 180 -> 270 -> normal (skips flipped variants 4..7)
      NEXT=$(( (CUR + 1) % 4 ))

      hyprctl keyword monitor "''${MON},transform,''${NEXT}"
    '';
  };
}
