{ config, pkgs, lib, ... }:
{
   home.packages = with pkgs; [
    hyprsunset
    hypridle
  ]; 

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    # xwayland.enable = true;

    settings = {

      xwayland.enable = true;

      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "nautilus";
      "$browser" = "firefox";
      "$menu" = "rofi -show drun -show-icons";
      "$update_script" = "kitty --class sysupdate -e bash ~/.dotfiles/system-update.sh";
      "$kitty_with_fastfetch" = "kitty fastfetch";
      # "$unhide_waybar" = "bash -c 'pkill -SIGUSR1 waybar; sleep 30; pkill -SIGUSR1 waybar'";
      "$unhide_waybar" = "bash -c 'pkill -SIGUSR1 waybar'";
      "$steam_friends" = "sleep 60 && steam steam://open/friends";

      exec-once = [
        "sleep 3 && signal-desktop"
        "sleep 1 && steam -silent"
        #"hyprpaper &"
        "hyprpanel"
        "$steam_friends"
        #"bash $HOME/.local/bin/video-wallpapers.sh"
      ];

      "ecosystem:no_update_news" = true; 

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
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
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
            color= "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations.enabled = true;

      cursor.inactive_timeout = 0;

      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 7, default"
        #"workspaces, 1, 6, default"
        "fade,1,7,default"
        "workspaces,1,7,default,slidevert"
      ];

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = false;  # new windows go to stack
        mfact = 0.5;  # master width
        allow_small_split = false; 

        #"new_status" = "master";
      };

      misc = {
        "force_default_wallpaper" = -1;
        "disable_hyprland_logo" = true;
        "enable_anr_dialog" = false;
      };

      bind = [
        
        "$mainMod, space, exec, $unhide_waybar"


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

      windowrulev2 = [
        #"workspace 9, class:^(steam)$, title:^(Friends)$" # open steamfriends on workspace 9
        #"workspace 5, class:^(steam_app_.*|starrail.exe)$" # send games to workspace 5 
        #"immediate, class:^(steam_app_.*|starrail.exe)$" # No animation delay
        #"noanim, class:^(steam_app_.*|starrail.exe)$" # No animation
        #"rounding 0, class:^(steam_app_.*|starrail.exe)$" # Don't round corners
        #"suppressevent maximize, class:.*" # Prevents maximize 
        #"idleinhibit always, class:^(steam_app_.*|starrail.exe)$" # prevent games from sleep



        "float, class:^(pavucontrol|nm-connection-editor)$" # Floating windows
        #"opacity 1.0 override 1.0, class:^(Steam)$" # Turn opacity off
        "nofocus, class:^$, title:^$, wayland:1, floating:1, fullscreen:0, pinned:0" # prevents hidden windows from being fuckwits
          
          "float, class:^(sysupdate)$" # update window top right
          "size 900 400, class:^(sysupdate)$" # window size
          "move 1650 80, class:^(sysupdate)$" # window position
          "noanim, class:^(sysupdate)$"
          "noblur, class:^(sysupdate)$"
      ];
    };
  };
}

