{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "nixup";
      runtimeInputs = with pkgs; [tmux git nix libnotify coreutils];
      text = ''
        SESSION=nixup
        FLAKE="$HOME/.dotfiles"
        HOST="$(hostname)"
        LOG="$HOME/.cache/nixup.log"

        # --- parent: detach into tmux and return immediately ---------------
        if [ "''${NIXUP_CHILD:-0}" != 1 ]; then
          if tmux has-session -t "$SESSION" 2>/dev/null; then
            echo "nixup already running (tmux attach -t $SESSION)" >&2
            exit 1
          fi
          tmux new-session -d -s "$SESSION" -e NIXUP_CHILD=1 "$0"
          echo "nixup started in tmux session '$SESSION'; log: $LOG"
          exit 0
        fi

        # --- child: runs detached inside tmux ------------------------------
        exec > >(tee "$LOG") 2>&1

        notify() { notify-send -a nixup "$1" "''${2:-}"; }
        fail() {
          notify-send -u critical -a nixup "nixup failed" "$1 — see $LOG"
          exit 1
        }
        trap 'fail "line $LINENO"' ERR

        BEFORE="$(readlink -f /run/current-system)"

        notify "nixup started" "pulling $FLAKE"
        cd "$FLAKE"
        git pull --rebase --autostash

        notify "Updating flake inputs"
        nix flake update

        notify "Rebuilding" "$HOST"
        sudo /run/current-system/sw/bin/nixos-rebuild switch --flake "$FLAKE#$HOST"

        AFTER="$(readlink -f /run/current-system)"

        if ! git diff --quiet || ! git diff --cached --quiet; then
          git add -A
          git commit -m "nixup: $(date -Iseconds)"
          git push
          PUSHED="pushed to origin"
        else
          PUSHED="no config changes to push"
        fi

        DIFF="$(nix store diff-closures "$BEFORE" "$AFTER" | head -n 20)"
        notify "nixup complete" "$PUSHED"$'\n'"''${DIFF:-no closure changes}"
      '';
    })
  ];

  security.sudo.extraRules = [
    {
      users = ["zozano"];
      commands = [
        {
          command = "/run/current-system/sw/bin/nixos-rebuild";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];
}
