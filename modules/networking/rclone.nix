{
  config,
  lib,
  pkgs,
  ...
}: let
  localDir = "/home/zozano/Proton-Drive";
  remoteDir = "proton:dectech-6af36c";
in {
  home-manager.users.zozano = { config, ... }: {
    programs.rclone = {
      enable = true;
      remotes.proton = {
        config.type = "protondrive";
        # secrets = # check ~/.dotfiles/modules/core/security.nix
      };
    };

    systemd.user.services.rclone-proton-sync = {
      Unit = {
        Description = "Sync ~/Proton-Drive with Proton Drive";
        After = ["network-online.target"];
        Wants = ["network-online.target"];
      };
      Service = {
        Type = "oneshot";
        ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${localDir}";
        ExecStart = lib.concatStringsSep " " [
          "${config.programs.rclone.package}/bin/rclone"
          "bisync"
          localDir
          remoteDir
          "--verbose"
          "--resilient"
          "--recover"
          "--max-lock=2m"
        ];
      };
    };

    systemd.user.timers.rclone-proton-sync = {
      Unit.Description = "Periodic Proton Drive sync";
      Timer = {
        OnBootSec = "5min";
        OnUnitActiveSec = "15min";
        Persistent = true;
      };

      Install.WantedBy = ["timers.target"];
    };
  };
}
