	
	##############
	### WAYBAR ###
	##############

	{ config, pkgs, lib, ... }: {
	
	programs.waybar = {
		enable = true;
	};
		
	programs.waybar = {
		settings = [{

			layer = "top";
			position = "top";
			
			modules-left = [
				"hyprland/workspaces"
				"tray"
				"custom/right-arrow-light"
			];
			
			modules-center = [
				"custom/left-arrow-dark"
				"custom/left-arrow-light"
				"clock#1"
				"custom/left-arrow-dark"
				"custom/left-arrow-light"
				"clock#2"
				"custom/right-arrow-light"
				"custom/right-arrow-dark"
				"clock#3"
				#"custom/right-arrow-light"
			];
			
			modules-right = [

				"custom/left-arrow-dark"
				"custom/left-arrow-light"
				"pulseaudio"
				"custom/left-arrow-dark"
				"custom/left-arrow-light"
				"memory"
				"custom/left-arrow-dark"
				"custom/left-arrow-light"
				"cpu"
				"custom/left-arrow-dark"
				"custom/left-arrow-light"
				"disk"
				"custom/left-arrow-dark"
				"custom/left-arrow-light"
				"custom/power"
			];
			

			"custom/left-arrow-dark" = {
				"format" = "  ";
				"tooltip" = false;
			};
			
			"custom/left-arrow-light" = {
				"format" = "  ";
				"tooltip" = false;
			};
			
			"custom/right-arrow-dark" = {
				"format" = "  ";
				"tooltip" = false;
			};
			
			"custom/right-arrow-light" = {
				"format" = "  ";
				"tooltip" = false;
			};

			
			"clock#1" = {
				"format" = "{:%A}";
				"tooltip" = false;
			};
			
			"clock#2" = {
				"format" = "{:%H:%M}";
				"tooltip" = false;
			};

			"clock#3" = {
				"format" = "{:%m-%d}";
				"tooltip" = false;
			};

			#clock = { 				#  
			##	format = "{:%H:%M} ";
			#	format-alt = " {:%Y-%m-%d} ";
			#	tooltip-format = "<tt><small>{calendar}</small></tt>"; 
			#	calendar = {
			#		mode = "year";
			#		mode-mon-col = 3;
			#		weeks-pos = "right";
			#		on-scroll = 1;
			#		format = {
			#			"months" = "<span color='#ffead3'><b>{}</b></span>";
			#			"days" = "<span color='#ffead3'><b>{}</b></span>";
			#			"weeks" = "<span color='#ffead3'><b>{}</b></span>";
			#			"weekdays" = "<span color='#ffead3'><b>{}</b></span>";
			#			"today" = "<span color='#ffead3'><b>{}</b></span>";
			#		};
			#	};
			#
			#	actions = {
			#		on-click-right = "mode";
			#		on-scoll-up = [
			#			"tz_up"
			#			"shift_up"
			#		];
			#		on-scroll-down = [
			#			"tz_down"
			#			"shift_down"
			#		];
			#	};
			#};

			"tray" = {
				"icon-size" = "20";
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
				format = "{volume}% {icon}" ;#{format_source}
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
				"format" = " ⏻ ";
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
		
		style = ''
			* {	
				font-size: 20px;
				font-family: monospace;
			}

			window#waybar {

				background: #292b2e;
				color: #fdf6e3;
			}

			#workspaces button {
				padding: 0 5px;
			}

			#custom-right-arrow-dark,
			#custom-left-arrow-dark {
				color: #1a1a1a;
			}
			
			#custom-right-arrow-light,
			#custom-left-arrow-light {
				color: #292b2e;
				background: #1a1a1a;
			}
		'';
	};
}
