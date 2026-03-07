{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    hyprsunset
    hypridle
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {

      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "nautilus";
      "$browser" = "firefox";
      "$menu" = "rofi -show drun -show-icons";
      "$update_script" = "kitty --class sysupdate -e bash ~/.dotfiles/system-update.sh";
      "$kitty_with_fastfetch" = "kitty fastfetch";
      # "$unhide_waybar" = "bash -c 'pkill -SIGUSR1 waybar; sleep 30; pkill -SIGUSR1 waybar'";
      #"$unhide_waybar" = "bash -c 'pkill -SIGUSR1 waybar'";
      #"$steam_friends" = "sleep 60 && steam steam://open/friends";

      exec-once = [
        "signal-desktop"
        "steam -silent"
        "coolercontrol"
	      "openrgb --startminimized -p Zozano"
        #"hyprpaper &"
        #"hyprpanel"
        #"$steam_friends"
        #"bash $HOME/.local/bin/video-wallpapers.sh"
      ];

      #"ecosystem:no_update_news" = true;

      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "MOZ_ENABLE_WAYLAND,1"
        "NIXOS_OZONE_WL,1"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "GTK_USE_PORTAL,1"
        "WLR_NO_HARDWARE_CURSORS,1"
        "__GL_VRR_ALLOWED,1"
      ];

      general = {
        gaps_in = 2;
        gaps_out = 5;
        border_size = 2;
        resize_on_border = false;
        allow_tearing = false;
        layout = "master";
      };

      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          range = 4;
          render_power = 3;
        };

        blur = {
          enabled = false;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations.enabled = false;

      cursor.inactive_timeout = 0;

      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 7, default"
        "fade,1,7,default"
        "workspaces,1,7,default,slidevert"
      ];

      # dwindle = {
      #   pseudotile = true;
      #   preserve_split = true;
      # };

      master = {
        new_status = false; # new windows go to stack
        mfact = 0.5; # master width
        allow_small_split = false;

        #"new_status" = "master";
      };

      misc = {
        "force_default_wallpaper" = -1;
        "disable_hyprland_logo" = true;
        "enable_anr_dialog" = false;
	"vfr" = true;
      };

      bind = [

        #"$mainMod, space, exec, $unhide_waybar"

        ", print, exec, grimblast save area ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
        "$mainMod, print, exec, grimblast copy area"

        "$mainMod, C, killactive,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, F, exec, $browser"
        "$mainMod, G, togglegroup,"
        "$mainMod, J, togglesplit,"
        "$mainMod, M, fullscreen, 1"
        "$mainMod, P, pseudo,"
        "$mainMod, Q, exec, $terminal"
        "$mainMod, R, exec, $menu"
        "$mainMod, V, togglefloating,"
        "$mainMod, num_lock, exec, $update_script"

        "$mainMod, return, exec, $terminal"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        "$mainMod, mouse_down, workspace, e-1"
        "$mainMod, mouse_up, workspace, e+1"

        "$mainMod SHIFT, mouse_down, movetoworkspace, -1"
        "$mainMod SHIFT, mouse_up, movetoworkspace, +1"

        #", mouse:276, workspace, +1"
        #", mouse:275, workspace, -1"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindl = [
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"

        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPrev, exec, playerctl previous"
        ",XF86AudioPlay, exec, playerctl play-pause"
      ];

	windowrule = [
		"workspace 2, match:class ^(steam)$, match:title ^(Friends)$" # open steamfriends on workspace 2
	 	"workspace 3, match:class ^(Terraria)$, match:title ^(Terraria)$" #Terraria
         	
		"workspace 5, immediate on, no_anim on, rounding 0, idle_inhibit always, match:class ^(steam_app_.*|starrail.exe)$"
         	
		#"suppressevent maximize, class:.*" # Prevents maximize

        	"float on, match:class ^(pavucontrol|nm-connection-editor)$" # Floating windows
        	"opacity 1.0 override 1.0 override, match:class ^(Steam)$" # Turn opacity off
        	"no_focus on, match:class ^$, match:title ^$, match:xwayland 0, match:float 1, match:fullscreen 0, match:pin 0" # prevents hidden windows from being fuckwits

        	"float on, size 900 400, move 1650 80, no_anim on, no_blur on, match:class ^(sysupdate)$" # update window top right
      ];
    };
  };
}
