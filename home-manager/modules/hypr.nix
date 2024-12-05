
	################
	### HYPRLAND ###
	################

	{ config, pkgs, lib, ... }:
{
	wayland.windowManager.hyprland.enable = true;

    wayland.windowManager.hyprland.plugins = with pkgs.hyprlandPlugins; [
        hyprtrails
    ];

      home.packages = with pkgs; [
        hyprsunset
      ];

    wayland.windowManager.hyprland.settings = {

		################
		### PROGRAMS ###
		################

		"$mainMod" = "SUPER";
		"$terminal" = "kitty";
		"$fileManager" = "nautilus";
		"$browser" = "firefox";
		"$menu" = "rofi -show drun -show-icons";

		#################
		### AUTOSTART ###
		#################

		exec-once = [
			"waybar"
			"sleep 1 && openrgb --startminimized -p Default.orp.ba"
			"sleep 3 && signal-desktop"
            "sleep 1 && steam -silent %U"
            "hyprctl setcursor Bibata-Modern-Classic 24"
            "bash ~/.local/share/applications/mount-server.sh"
			#"pypr" #???
		];

        env = [
          "LIBVA_DRIVER_NAME,nvidia"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        ];
        

		#####################
		### LOOK AND FEEL ###
		#####################

		general = {
			
			gaps_in = 5;
			gaps_out = 10;
			border_size = 2;
			"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
			"col.inactive_border" = "rgba(595959aa)";
			resize_on_border = false;
			allow_tearing = false;
			layout = "dwindle";
		};

		decoration = {
			
			rounding = 10;
			active_opacity = 1.0;
			inactive_opacity = 1.0;
			drop_shadow = true;
			shadow_range = 4;
			shadow_render_power = 3;
			"col.shadow" = "rgba(1a1a1aee)";

			blur = {
				enabled = true;
				size = 3;
				passes = 1;
				vibrancy = 0.1696;
			};
		};


		animations.enabled = true;

		bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
	

		animation = [
			
			"windows, 1, 7, myBezier"
			"windowsOut, 1, 7, default, popin 80%"
			"border, 1, 10, default"
			"borderangle, 1, 7, default"
			"workspaces, 1, 6, default"
		];

		dwindle = {

			pseudotile = true;
			preserve_split = true;
		};

		master = {
		
			"new_status" = "master";
		};

		misc = {
			"force_default_wallpaper" = -1;
			"disable_hyprland_logo" = false;
		};

		###################
		### KEYBINDINGS ###
		###################

		bind = [

			", print, exec, grimblast save area ~/Pictures/$(date +%Y-%m-%d_%H-%M-%S).png"
			"$mainMod, print, exec, grimblast copy area"			

			"$mainMod, Q, exec, $terminal"
			"$mainMod, return, exec, $terminal"
			"$mainMod, C, killactive,"
			"$mainMod, E, exec, $fileManager"
			"$mainMod, F, exec, $browser"
			"$mainMod, R, exec, $menu"
			"$mainMod, P, pseudo,"
			"$mainMod, J, togglesplit,"

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
		];

		bindm = [
			
			"$mainMod, mouse:272, movewindow"
			"$mainMod, mouse:273, resizewindow"
		];

		bindl = [
          

			",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
			",XF86MonBrightnesUp, exec, brightnessctl s 10%+"
			",XF86MonBrightnessDown, exec, brightnessctl s 10%-"

            ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
			",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
			",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

			",XF86AudioNext, exec, playerctl next"
			",XF86AudioPrev, exec, playerctl previous"
			",XF86AudioPlay, exec, playerctl play-pause"
		];

		windowrulev2 = [
            "workspace 1,title:(Kitty)"
            "workspace 1,class:(firefox)"
			"workspace 9,title:(Star Rail)"
			"workspace 10,title:(Fallout)"
            "workspace 11,title:(Valheim)"
            "workspace 12,title:(Shovel Knight)"
            "workspace 13,title:(Payday)"
			"suppressevent maximize, class:.*"
			"nofocus,class:^$,title:^$,wayland:1,floating:1,fullscreen:0,pinned:0"
		];

	};
}
