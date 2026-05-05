# ~/.dotfiles/modules/boot-and-shutdown-logs.nix
#
# - export-boot-log:     after multi-user.target is reached, dumps the CURRENT
#                        boot's journal to ~/.dotfiles/boot.log. Captures the
#                        boot phase + anything up to the moment it runs.
#
# - export-shutdown-log: ExecStop fires during shutdown and dumps the CURRENT
#                        boot's full journal (boot + runtime + early shutdown
#                        sequence so far) to ~/.dotfiles/shutdown.log.
{
  config,
  pkgs,
  ...
}: let
  user = "zozano";
  logDir = "/home/${user}/.dotfiles";
  journalctl = "${config.systemd.package}/bin/journalctl";
in {
  systemd.services.export-boot-log = {
    description = "Export current boot journal to ${logDir}/boot.log";
    wantedBy = ["multi-user.target"];
    after = ["multi-user.target" "systemd-journald.service"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "export-boot-log" ''
        set -euo pipefail
        ${journalctl} -b 0 --no-pager > ${logDir}/boot.log
        chown ${user}:users ${logDir}/boot.log
        chmod 644 ${logDir}/boot.log
      '';
    };
  };

  systemd.services.export-shutdown-log = {
    description = "Export full session journal to ${logDir}/shutdown.log on shutdown";
    wantedBy = ["multi-user.target"];
    after = ["multi-user.target" "systemd-journald.service"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      # No-op on start; the work happens on stop (i.e. shutdown/reboot).
      ExecStart = "${pkgs.coreutils}/bin/true";
      ExecStop = pkgs.writeShellScript "export-shutdown-log" ''
        set -euo pipefail
        ${journalctl} -b 0 --no-pager > ${logDir}/shutdown.log
        chown ${user}:users ${logDir}/shutdown.log
        chmod 644 ${logDir}/shutdown.log
      '';
    };
  };
}
