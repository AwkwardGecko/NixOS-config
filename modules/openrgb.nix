###############
### OPENRGB ###
###############

{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.hardware.openrgb = {
    enable = true;
  };

  systemd.user.services.openrgb-autostart = {
    description = "OpenRGB minimized with profile";
    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.openrgb}/bin/openrgb --startminimized -p Default.orp.ba";
      Restart = "on-failure";
    };

    wantedBy = [ "graphical-session.target" ];
  };
}
