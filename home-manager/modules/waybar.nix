##############
### WAYBAR ###
##############

#   			 	 	 󰍛	 󰍜	 󰒓 󰘚	

# 						 
{
  config,
  pkgs,
  lib,
  ...
}:
{

  programs.waybar = {
    enable = true;
    settings = [
      {

        layer = "top";
        position = "top";

        modules-left = [
          "custom/cpuload"
          "custom/cputemp"
          "custom/gpuload"
          "custom/gputemp"
          "custom/gpuvram"
          "memory"
        ];

        modules-center = [
          "clock#date"
          "hyprland/workspaces"
          "clock#time"
        ];

        modules-right = [
          "custom/update"
          "tray"
          "gamemode"
          "pulseaudio"
          #"disk"
          #"bluetooth"
          "custom/power"
        ];

        # "notifications" = {
        #   format = "{message}";
        #   max-length = 200;
        #   icon-size = 32;
        # };

        "hyprland/window" = {
          format = "{initialTitle}";
          max-length = 40;
          # rewrite = {
          # "(.*) — Mozilla Firefox" = "🌎 $1";
          # "(.*) - fish" = "> [$1]";
          # };
          "separate-outputs" = true;
        };

        "clock#date" = {
          format = "󰨳 {:%A %B %d}";
          #tooltip = false;
        };

        "clock#time" = {
          format = "󱑂 {:%I:%M %p}";
          #tooltip = false;
        };

        tray = {
          icon-size = 21;
          spacing = 10;
        };

        gamemode = {
          format = "{glyph}";
          format-alt = "{glyph} {count}";
          glyph = "";
          hide-not-running = true;
          use-icon = true;
          icon-name = "input-gaming-symbolic";
          icon-spacing = 0;
          icon-size = 20;
          #tooltip = true;
          #tooltip-format = "Games running: {count}";
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          icon-size = 20;
          icon-spacing = 0;
          format-muted = "󰝟 {volume}%";
          format-icons = {
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = "pavucontrol";
        };

        disk = {
          interval = 30;
          icon-size = 20;
          icon-spacing = 0;
          format = "{percentage_used}% 󰋊";
          path = "/home";
          #tooltip = true;
          unit = "GB";
          #tooltip-format = "Available {free} of {total}";
        };

        memory = {
          interval = 10;
          icon-size = 20; 
          icon-spacing = 0;
          format = " {percentage}%";
          #max-length = 10;
          #tooltip = true;
          #tooltip-format = "RAM - {used:0.1f}GiB used";
        };

        temperature = {
          icon-size = 20;
          icon-spacing = 0;
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = [
            ""
            ""
            ""
          ];
        };

        bluetooth = {
          icon-size = 20;
          icon-spacing = 0;
          interval = 30;
          format = "{icon}";
          format-alt = "{status}";
          format-icons = {
            enabled = "On ";
            disabled = "Off ";
          };
          on-click = "blueman-manager";
        };

        mpris = {
          format = "{player_icon} {title} [{artist}]";
          interval = 1;
          format-paused = "{status_icon} <i>{dynamic}</i>";
          player-icons = {
            default = "▶";
            mpv = "🎵";
          };
          status-icons = {
            paused = "⏸";
          };
          ignored-players = [ "firefox" ];
        };
        
        # cpu = {
        #   format = "CPU   {usage}%";
        #   icon-size = 20;
        #   icon-spacing = 0;
        #   #tooltip = true;
        # };
        
        "custom/cpuload" = {
            format = "  {}%";
            exec = "printf '%02d\\n' $(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print int(usage)}')";
            interval = 5;
            return-type = "";
            icon-size = 20;
            icon-spacing = 0;
        };
       
        "custom/gpuvram" = {
          format = "󰘚 {}";
          icon-size = 20;
          icon-spacing = 0;
          return-type = ""; 
          exec = "nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader,nounits | awk -F',' '{ printf \"%02d%%\\n\", int(($1 / $2) * 100) }'";
  # exec = "nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader,nounits | awk -F',' '{ 
  #   val=int(($1 / $2) * 100); 
  #   if (val <= 50) { print \"low\"; } 
  #   else if (val <= 80) { print \"medium\"; } 
  #   else { print \"high\"; } 
  # }'";
          interval = 5;
         };

        "custom/update" = {
          format = "   ";
          icon-size = 20;
          icon-spacing = 0;
          on-click = "kitty --hold /usr/bin/env bash -c '/home/zozano/.dotfiles/system-update.sh'";
          return-type = "";
          interval = 5;
         };


        "custom/gputemp" = {
          format = " {}°C";
          icon-size = 20;
          icon-spacing = 0;
          exec = "nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits";
          return-type = "";
          interval = 5;
         };

        "custom/gpuload" = {
          icon-size = 20;
          icon-spacing = 0;
          format = "  {}%";
          return-type = "";
          exec = "printf '%02d\\n' $(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)";
          #exec = "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits";
          interval = 5;
        };

        "custom/cputemp" = {
          icon-size = 20;
          icon-spacing = 0;
          format = " {}°C";
          return-type = "";
          exec = "cat /sys/class/thermal/thermal_zone0/temp | awk '{print $1 / 1000}'";
          interval = 10;
        };

        "custom/power" = {
          icon-size = 20;
          icon-spacing = 0;
          format = "⏻ ";
          #tooltip = true;
          on-click = "shutdown now";
          on-click-right = "reboot";
          #on-click = "menu";
          #menu = "on-click";
          #menu-file = "~/.local/share/applications/power_menu.xml"; # Menu file in resources folder
        };

        "menu-actions" = {
          "shutdown" = "shutdown";
          "reboot" = "reboot";
          "suspend" = "systemctl suspend";
          "hibernate" = "systemctl hibernate";
        };
      }
    ];

   style = ''
        * {	
            border: none;
            border-radius: 10px;
            font-size: 15px;
            font-family: "JetBrainsMono Nerd Font", monospace;
        }

        window#waybar {
            background: transparent;
        }

        window#waybar.hidden {
            opacity: 0.2;
        }

        @keyframes blink {
            to {
                background-color: #BF616A;
                color: #B5E8E0;
            }
        }

        #custom-gpuvram {
            margin-top: 6px;
            margin-left: 8px;
            padding-left: 10px;
            margin-bottom: 0px;
            padding-right: 10px;
            color: #B5E8E0;
            transition: none;
            border-radius: 10px;
            background: #161320;
        }


        #window {
            margin-top: 6px;
            padding-left: 10px;
            padding-right: 10px;
            border-radius: 10px;
            transition: none;
            background: transparent;
        }

        #custom-gputemp {
            margin-top: 6px;
            margin-left: 8px;
            padding-left: 10px;
            margin-bottom: 0px;
            padding-right: 10px;
            border-radius: 10px;
            transition: none;
            color: #B5E8E0;
            background: #161320;
        }

        #custom-update {
            margin-top: 6px;
            margin-left: 8px;
            padding-left: 10px;
            margin-bottom: 0px;
            padding-right: 10px;
            border-radius: 10px;
            transition: none;
            color: #B5E8E0;
            background: #161320;
        }

        #custom-cputemp {
            margin-top: 6px;
            margin-left: 8px;
            padding-left: 10px;
            margin-bottom: 0px;
            padding-right: 10px;
            border-radius: 10px;
            transition: none;
            color: #B5E8E0;
            background: #161320;
        }

        #custom-cpuload {
            margin-top: 6px;
            margin-left: 8px;
            padding-left: 10px;
            margin-bottom: 0px;
            padding-right: 10px;
            border-radius: 10px;
            transition: none;
            color: #B5E8E0;
            background: #161320;
        }

        #custom-gpuload {
            margin-top: 6px;
            margin-left: 8px;
            padding-left: 10px;
            margin-bottom: 0px;
            padding-right: 10px;
            border-radius: 10px;
            transition: none;
            color: #B5E8E0;
            background: #161320;
        }



        #bluetooth {
            margin-top: 6px;
            margin-left: 8px;
            padding-left: 10px;
            margin-bottom: 0px;
            padding-right: 10px;
            border-radius: 10px;
            transition: none;
            color: #B5E8E0;
            background: #161320;
        }

        #mpris {
            margin-top: 6px;
            margin-left: 8px;
            padding-left: 10px;
            margin-bottom: 0px;
            padding-right: 10px;
            border-radius: 10px;
            transition: none;
            color: #B5E8E0;
            background: #161320;
        }

        #gamemode {
            margin-top: 6px;
            margin-left: 8px;
            padding-left: 10px;
            margin-bottom: 0px;
            padding-right: 10px;
            border-radius: 10px;
            transition: none;
            color: #B5E8E0;
            background: #161320;
        }

        #pulseaudio {
            margin-top: 6px;
            margin-left: 8px;
            padding-left: 10px;
            margin-bottom: 0px;
            padding-right: 10px;
            border-radius: 10px;
            transition: none;
            color: #B5E8E0;
            background: #161320;
        }

        #disk {
            margin-top: 6px;
            margin-left: 8px;
            padding-left: 10px;
            margin-bottom: 0px;
            padding-right: 10px;
            border-radius: 10px;
            transition: none;
            color: #B5E8E0;
            background: #161320;
        }

        #clock {
            margin-top: 6px;
            margin-left: 8px;
            padding-left: 10px;
            margin-bottom: 0px;
            padding-right: 10px;
            border-radius: 10px;
            transition: none;
            color: #B5E8E0;
            background: #161320;
        }

        #memory {
            margin-top: 6px;
            margin-left: 8px;
            padding-left: 10px;
            margin-bottom: 0px;
            padding-right: 10px;
            border-radius: 10px;
            transition: none;
            color: #B5E8E0;
            background: #161320;
        }

        #cpu {
            margin-top: 6px;
            margin-left: 8px;
            padding-left: 10px;
            margin-bottom: 0px;
            padding-right: 10px;
            border-radius: 10px;
            transition: none;
            color: #B5E8E0;
            background: #161320;
        }

        #tray {
            margin-top: 6px;
            margin-left: 8px;
            padding-left: 10px;
            margin-bottom: 0px;
            padding-right: 10px;
            border-radius: 10px;
            transition: none;
            color: #B5E8E0;
            background: #161320;
        }

        #custom-launcher {
            font-size: 24px;
            margin-top: 6px;
            margin-left: 8px;
            padding-left: 10px;
            padding-right: 5px;
            border-radius: 10px;
            transition: none;
            color: #89DCEB;
            background: #161320;
        }

        #custom-power {
            margin-top: 6px;
            margin-left: 8px;
            padding-left: 10px;
            margin-bottom: 0px;
            padding-right: 10px;
            border-radius: 10px;
            transition: none;
            color: #B5E8E0;
            background: #161320;
        }

        #workspaces {
            margin-top: 6px;
            margin-left: 8px;
            padding-left: 10px;
            margin-bottom: 0px;
            padding-right: 10px;
            border-radius: 10px;
            transition: none;
            color: #B5E8E0;
            background: #161320;
        }

        #workspaces button {
            padding: 0 5px;
            background-color: transparent;
            color: #ffffff;
        }

        #workspaces button:hover {
            background: rgba(0, 0, 0, 0.2);
        }

        #workspaces button.focused {
            background-color: #64727D;
            box-shadow: inset 0 -3px #ffffff;
        }

        #workspaces button.urgent {
            background-color: #eb4d4b;
        }


    '';
  };
}
