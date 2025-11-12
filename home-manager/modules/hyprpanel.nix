{ config, lib, pkgs, ... }:
{





  systemd.user.services.xembedsniproxy = {
    Unit = {
      Description = "XEmbed → SNI tray proxy";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.kdePackages.xembed-sni-proxy}/bin/xembedsniproxy";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };








  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    settings = {
     
      theme.font = {
        name = "JetBrainsMono Nerd Font";
        size = 16;
      };


      bar.tray = {
        enable = true;
        iconSize = 22;
      };

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
