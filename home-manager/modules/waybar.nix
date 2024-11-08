	
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
			];
			
			modules-center = [
				"clock#1"
				"clock#2"
			];
			
			modules-right = [

				"pulseaudio"
				"memory"
				"cpu"
				"disk"
				"custom/power"
			];
			
			"clock#1" = {
				"format" = "{:%A %B %d %I:%M %p}";
				"tooltip" = false;
			};
			
			"clock#2" = {
				"format" = "{:%I:%M %p}";
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

			tray = {
				"icon-size" = 25;
				"spacing" = 6;
			};

			cpu = {
				format = "{usage}%  ";
				tooltip = true;
			};

			disk = {
				interval = 30;
				format = "{percentage_used}% 󰋊";
				path = "/";
				tooltip = true;
				unit = "GB";
				tooltip-format = "Available {free} of {total}";
			};

			memory = { format = "{}%  "; };
			
			pulseaudio = {
				format = "{volume}% {icon} " ;#{format_source}
				#format-bluetooth = "{volume}% {icon} "; #{format_source}
				#format-bluetooth<D-y><D-h><D-h>-muted = " {icon} "; #{format_source}
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
				"format" = "⏻ ";
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
				border: none;
				border-radius: 10;
				font-size: 15px;
				font-family: "JetbrainsMono Nerd Font";
			}

			window#waybar {
				background: transparent;
			}

			window#waybar.hidden {
				opacity: 0.2;
			}
			
			#window {
				margin-top: 6px;
				padding-left: 10px;
				padding-right: 10px;
				border-radius: 10px;
				transition: none;
				color: transparent;
				background: transparent;
			}

			#tags {
				margin-top: 6px;
				margin-left: 12px;
				font-size: 4px;
				margin-bottom: 0px;
				border-radius: 10px;
				background: #161320;
				transition: none;
			}

			#tags button {
				transition: none;
				color: #B5E8E0;
				background: transparent;
				font-size: 16px;
				border-radius: 2px;
			}

			#tags button.occupied {
				transition: none;
				color: #F28FAD;
				background: transparent;
				font-size: 4px;
			}

			#tags button.focused {
				color: #ABE9B3;
				border-top: 2px solid #ABE9B3;
				border-bottom: 2px solid #ABE9B3;
			}

			#tags button:hover {
				transition: none;
				box-shadow: inherit;
				text-shadow: inherit;
				color: #FAE3B0;
				border-color: #E8A2AF;
				color: #E8A2AF;
			}

			#tags button.focused:hover {
				color: #E8A2AF;
			}

			#network {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 10px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: #161320;
				background: #bd93f9;
			}

			#pulseaudio {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 10px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: #1A1826;
				background: #FAE3B0;
			}

			@keyframes blink {
				to {
					background-color: #BF616A;
					color: #B5E8E0;
				}
			}

			#disk {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 10px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: #161320;
				background: #F8BD96;
			}
			#clock {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 10px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: #161320;
				background: #ABE9B3;
				/*background: #1A1826;*/
			}

			#memory {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				margin-bottom: 0px;
				padding-right: 10px;
				border-radius: 10px;
				transition: none;
				color: #161320;
				background: #DDB6F2;
			}

			#cpu {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				margin-bottom: 0px;
				padding-right: 10px;
				border-radius: 10px;
				transition: none;
				color: #161320;
				background: #96CDFB;
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
				font-size: 20px;
				margin-top: 6px;
				margin-left: 8px;
				margin-right: 8px;
				padding-left: 10px;
				padding-right: 5px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: #161320;
				background: #F28FAD;
			}

			#custom-wallpaper {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 10px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: #161320;
				background: #C9CBFF;
			}

			#custom-updates {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 10px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: #161320;
				background: #E8A2AF;
			}

			#custom-media {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 10px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: #161320;
				background: #F2CDCD;
			}

		'';
	};
}
