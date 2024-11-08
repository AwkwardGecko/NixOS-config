	
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
			"hyprland/mode"
		];
		
		modules-center = [
			#"hyprland/window"
		];
		
		modules-right = [

			"network"
			"pulseaudio"
			"cpu"
			"memory"
			"temperature"
		]

		++ [
			"clock"
			"tray"
		];
		
		clock = {
			format-alt = "{:%Y-%m-%d}";
			tooltip-format = "{:%Y-%m-%d | %H:%M}";
		};

		cpu = {
			format = "{usage}% ";
			tooltip = true;
		};

		memory = { format = "{}% "; };
		
		network = {
			interval = 1;
			format-alt = "{ifname}: {ipaddr}/{cidr}";
			format-disconnected = "Disconnected ⚠";
			format-ethernet = "{ifname}: {ipaddr}/{cidr}   up: {bandwidthUpBits} down: {bandwidthDownBits}";
			format-linked = "{ifname} (No IP) ";
			format-wifi = "{essid} ({signalStrength}%) ";
		};

		pulseaudio = {
			format = "{volume}% {icon} {format_source}";
			format-bluetooth = "{volume}% {icon} {format_source}";
			format-bluetooth-muted = " {icon} {format_source}";
			format-muted = " {format_source}";
			#format-source = "{volume}% ";
			#format-source-muted = "";
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
			format = "temperatureC}°C {icon}";
			format-icons = [
				""
				""
				""
			];
		};
    	}];
}
