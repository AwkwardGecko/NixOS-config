{ config, lib, pkgs, ... }:
{
  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    settings = {
      
      bar.launcher.autoDetectIcon = true;
      #bar.dashboard.icon = "󱄅";
      bar.battery.label = true;
      bar.bluetooth.label = false;
      bar.clock.format = "%H:%M";
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
            "steam"
          ];
        };
      };
    };
  };
}
