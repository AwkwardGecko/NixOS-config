######################
### SYSTEMD TIMERS ###
######################

{
  config,
  pkgs,
  lib,
  ...
}:
{
  systemd.timers."teamviewer" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5m";
      onUnitActivateSec = "5m";
      Unit = "teamviewer.service";
    };
  };
}
