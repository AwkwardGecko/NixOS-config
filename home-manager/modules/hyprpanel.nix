{ config, lib, pkgs, ... }:
{
  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    settings = {
      bar.battery.label = true;
      bar.bluetooth.label = false;
      bar.clock.format = "%H:%M:%S";
      bar.layouts = {
        "*" = {
          left = [
            "volume"
            "media"
          ];

          middle = [ 
            #"windowtitle"
            #"workspaces"
            "clock"
          ];

          right = [
            #"network"
            "bluetooth"
            "notifications"
            "dashboard"
          ];
        };
      };
    };
  };
}
