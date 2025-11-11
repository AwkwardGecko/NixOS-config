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
    Unit.Description = "OpenRGB minimized with profile";
    
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.openrgb}/bin/openrgb --startminimized -p Default.orp.ba";
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}
