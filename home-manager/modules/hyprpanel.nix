{ config, lib, pkgs, ... }:
{
  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    settings = {
     
      theme.font = {
        name = "JetBrainsMono";
        size = "16px";
      };

      bar.tray = {
        enable = true;
        iconSize = 22;
      };

      modules.weather = {
        enable = true;
        location = "Port Macquarie, NSW, Australia";
        units = "metric";
      };

      bar.launcher.autoDetectIcon = true;
      #bar.dashboard.icon = "󱄅";
      #bar.battery.label = true;
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
            "tray"
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
