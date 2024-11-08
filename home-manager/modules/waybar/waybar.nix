	
	##############
	### WAYBAR ###
	##############

	{ config, pkgs, lib, ... }: {
	
	programs.waybar = {
		enable = true;
	};
		
	programs.waybar.settings = [{

		height = 30;
		layer = "top";
		position = "top";
		tray = { spacing = 10; };
		
		modules-left = [

			"hyprland/workspaces"    
		];
		
		modules-center = [
			"clock"
		];
		
		modules-right = [

			#"network"
			"pulseaudio"
			"cpu"
			"memory"
			"temperature"
			"tray"
			"custom/power"
		];
		
		clock = { 				#  
			format = "{:%H:%M} ";
			format-alt = " {:%Y-%m-%d} ";
			tooltip-format = "<tt><small>{calendar}</small></tt>"; 
			calendar = {
				mode = "year";
				mode-mon-col = 3;
				weeks-pos = "right";
				on-scroll = 1;
				format = {
					"months" = "<span color='#ffead3'><b>{}</b></span>";
					"days" = "<span color='#ffead3'><b>{}</b></span>";
					"weeks" = "<span color='#ffead3'><b>{}</b></span>";
					"weekdays" = "<span color='#ffead3'><b>{}</b></span>";
					"today" = "<span color='#ffead3'><b>{}</b></span>";
				};
			};

			actions = {
				on-click-right = "mode";
				on-scoll-up = [
					"tz_up"
					"shift_up"
				];
				on-scroll-down = [
					"tz_down"
					"shift_down"
				];
			};
		};

		cpu = {
			format = "{usage}%  ";
			tooltip = true;
		};

		memory = { format = "{}%  "; };
		
		network = {
			interval = 1;
			format-alt = "{ifname}: {ipaddr}/{cidr}";
			format-disconnected = "Disconnected ⚠";
			format-ethernet = "{ifname}: {ipaddr}/{cidr}   up: {bandwidthUpBits} down: {bandwidthDownBits}";
			format-linked = "{ifname} (No IP) ";
			format-wifi = "{essid} ({signalStrength}%) ";
		};

		pulseaudio = {
			format = "{volume}% {icon} " ;#{format_source}
			#format-bluetooth = "{volume}% {icon} "; #{format_source}
			#format-bluetooth-muted = " {icon} "; #{format_source}
			#format-muted = " {format_source}";
			#format-source = "{volume}% ";
			format-source-muted = "";
			on-click = "pavucontrol";

			format-icons = {
				car = "";
				default = [ "" "" "" ];
				handsfree = "";
				headphones = "";
				headset = "";
				phone = "";
				portable = "";
			};

		};
	
		"hyprland/mode" = { 
			format = ''<span style="italic">{}</span>'';
		};

		temperature = {
			critical-threshold = 80;
			format = "{temperatureC}°C {icon}";
			format-icons = [
				""
				""
				""
			];
		};
		
		"custom/power" = {
			"format" = "  ⏻  ";
			"tooltip" = true;
			"menu" = "on-click";
			"menu-file" = "~/.dotfiles/home-manager/modules/waybar/power_menu.xml"; # Menu file in resources folder
		};

		"menu-actions" = {
			"shutdown" = "shutdown";
			"reboot" = "reboot";
			"suspend" = "systemctl suspend";
			"hibernate" = "systemctl hibernate";
		};
	}];
}
