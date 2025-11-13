{ config, lib, pkgs, ... }:
{
  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    settings = {
      
      notifications = {
        enable = true;
        autoDismiss = true;
        dismissTimeout = 5000;
      };


      theme.font = {
        name = "JetBrainsMono Nerd Font";
        #style = "Regular";
        size = "1.2rem";
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
            "workspaces"
          ];

          middle = [ 
            #"windowtitle"
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
