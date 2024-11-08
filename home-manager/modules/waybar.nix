	
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
			# height = 24;
			# mode = "dock";
			# exclusive = true;

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
				"bluetooth"
				"custom/power"
			];
			
			"clock#1" = {
				format = "{:%A %B %d}";
				tooltip = false;
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
				icon-size = 25;
				spacing = 6;
			};

			cpu = {
				format = "{usage}%  ";
				tooltip = true;
			};

			disk = {
				interval = 30;
				format = "{percentage_used}% 󰋊 ";
				path = "/";
				tooltip = true;
				unit = "GB";
				tooltip-format = "Available {free} of {total}";
			};

			memory = {
        		interval = 10;
				format = "  {percentage}%";
				max-length = 10;
				tooltip = true;
				tooltip-format = "RAM - {used:0.1f}GiB used";
			};
			
			pulseaudio = {
				format = "{volume}% {icon} " ;#{format_source}
				format-source-muted = "";
				on-click = "pavucontrol";
			};
			
			#hyprland/mode = { 
			#	format = ''<span style="italic">{}</span>'';
			#};

			temperature = {
				critical-threshold = 80;
				format = "{temperatureC}°C {icon}";
				format-icons = [
					""
					""
					""
				];
			};
			
			bluetooth = {
				interval = 30;
				format = "{icon}";
        		format-alt = "{status}";
				format-icons = {
            		enabled = "On  ";
					disabled = "Off  ";
				};
			on-click = "blueberry";
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
		
		style = [{
			
			border = "none";
			border-radius = 10;
			font-size = 15px;
			font-family = "JetbrainsMono Nerd Font";
		}];

	
	};
}
