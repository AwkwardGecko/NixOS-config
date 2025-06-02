{ config, lib, pkgs, ... }:

let
  scriptPath = "/home/zozano/temp/hdd-zeroing.sh";
  stateFile = "/home/zozano/temp/hdd-zeroing.done";
in {
  systemd.services.hdd-zeroing = {
    description = "Incremental HDD zeroing step";
    wantedBy = [ ];
    path = [ pkgs.coreutils pkgs.util-linux pkgs.gnugrep pkgs.gnused ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${scriptPath}";
      ConditionPathExists = "!${stateFile}";
    };
  };

  systemd.timers.hdd-zeroing = {
    description = "Run HDD zeroing every 30 seconds";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "50s";
      OnUnitActiveSec = "50s";
      Unit = "hdd-zeroing.service";
      Persistent = true;
    };
  };
}

