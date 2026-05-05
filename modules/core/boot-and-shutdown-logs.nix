# ~/.dotfiles/modules/boot-and-shutdown-logs.nix
#
# - export-boot-log:     after multi-user.target is reached, dumps the CURRENT
#                        boot's journal to ~/.dotfiles/boot.log.
#
# - export-shutdown-log: ExecStop fires during shutdown and dumps the CURRENT
#                        boot's journal (boot + runtime + early shutdown
#                        sequence so far) to ~/.dotfiles/shutdown.log.
#
# Lines from chatty services (see `excludedUnits`) are filtered out by matching
# their syslog identifier in journalctl's short format ("<host> <ident>[<pid>]:").
# systemd's own lifecycle messages ("Started foo.service", "Stopped foo.service")
# are emitted by systemd[1] and are preserved.
{
  config,
  pkgs,
  lib,
  ...
}: let
  user = "zozano";
  logDir = "/home/${user}/.dotfiles";
  journalctl = "${config.systemd.package}/bin/journalctl";
  grep = "${pkgs.gnugrep}/bin/grep";

  # Add more identifiers here as needed. Use the syslog identifier
  # (usually the unit name without ".service"), not the full unit name.
  excludedUnits = ["tdarr-node" "monerod"];
  excludeRegex = " (${lib.concatStringsSep "|" excludedUnits})\\[";

  dumpScript = name: outFile:
    pkgs.writeShellScript "export-${name}-log" ''
      set -eu
      ${journalctl} -b 0 --no-pager \
        | ${grep} -vE '${excludeRegex}' \
        > ${outFile} || true
      chown ${user}:users ${outFile}
      chmod 644 ${outFile}
    '';
in {
  systemd.services.export-boot-log = {
    description = "Export current boot journal to ${logDir}/boot.log";
    wantedBy = ["multi-user.target"];
    after = ["multi-user.target" "systemd-journald.service"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = dumpScript "boot" "${logDir}/boot.log";
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
      ExecStop = dumpScript "shutdown" "${logDir}/shutdown.log";
    };
  };
}
