{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    settings = {

      bar.layouts = {
        "*" = {
          left = [
            "volume"
            "media"
            "workspaces"
          ];
          middle = [ "clock" ];
          right = [
            "systray"
            "bluetooth"
            "notifications"
            "dashboard"
          ];
          # unused: "network" "windowtitle"
        };
      };

      notifications = {
        enabled = true;
        autoDismiss = true;
        dismissTimeout = 5000;
      };

      theme = {
        font = {
          name = "JetBrainsMono Nerd Font";
          #style = "Regular";
          size = "1.2rem";
        };
        bar.transparent = true;
      };

	wallpaper.enable = false;

      bar = {
        tray = {
          enable = true;
          iconSize = 22;
        };
        launcher.autoDetectIcon = true;
        workspaces.show_icons = true;
        #dashboard.icon = "󱄅";
        #battery.label = true;
        bluetooth.label = false;
        clock.format = "%H:%M";
      };

      # modules.weather = {
      #   enable = true;
      #   location = "Port Macquarie, NSW, Australia";
      #   units = "metric";
      #   api_key = "cd8270d44cfa4514b6145250260801";
      # };

	theming.general.applyWallpapers = false;

      menus = {
        clock = {
          time = {
            military = true;
            hideSeconds = true;
          };
          weather = {
            unit = "metric";
            key = "cd8270d44cfa4514b6145250260801";
            location = "-31.43127,152.908131";
          };
        };
        dashboard = {
          directories.enabled = false;
          enable_gpu = true;
        };
      };
    };
  };
}
