	
	##############
	### WAYBAR ###
	##############

	{ config, pkgs, lib, ... }: {
	
	programs.waybar = {
		enable = true;
		settings = [{

			"layer" = "top";
			"position" = "top";
			"height" = 24;
			"mode" = "dock";
			"exclusive" = true;
			"passthrough" = false;
			"reload_style_on_change" = true;
			"gtk-layer-shell" = true;

			# === Positions ===

			"modules-left" = [
				"custom/ws"            # window icon
				"custom/left1"

				"hyprland/workspaces"  # workspaces
				"custom/right1"

				"custom/paddw"
				"hyprland/window"       # window title
			];

			"modules-center" = [
				"custom/paddc"
				"custom/left2"
				"custom/cpuinfo"       # temperature

				"custom/left3"
				"memory"               # memory

				"custom/left4"
				"custom/cpu"          # cpu
				"custom/leftin1"

				"custom/left5"
				"idle_inhibitor"       # arch logo
				"custom/right2"

				"custom/rightin1"
				"clock#time"          # time
				"custom/right3"

				"clock#date"	        # date
				"custom/right4"

				"custom/wifi"        # wi-fi
				"custom/right5"
			];

			"modules-right" = [
				"custom/media"         # media info

				"custom/left6"
				"pulseaudio"           # output device

				"custom/left7"
				"custom/backlight"     # brightness

				"custom/left8"
				"battery"              # battery

				"custom/leftin2"
				"custom/power"			# power button
			];

			# === Modules ===

			"custom/ws" = {
				"format" = "  ";
				"tooltip" = false;
				"min-length" = 3;
				"max-length" = 3;
			};

			"hyprland/workspaces" = {
				"all-outputs" = false;
				"active-only" = false;
				"on-click" = "activate";
				"disable-scroll" = false;
				"on-scroll-up" = "hyprctl dispatch workspace -1";
				"on-scroll-down" = "hyprctl dispatch workspace +1";
				"sort-by-number" = true;
				"persistent-workspaces" = {
					"1" = [];
					"2" = [];
					"3" = [];
					"4" = [];
					"5" = [];
				};
			};

			"hyprland/window" = {
				"format" = "{}";
				"separate-outputs" = true;
				"min-length" = 5;
				"max-length" = 45;

				# === Window Titles ===
				
				"rewrite" = {
				# == Desktop == 
					
					"" = "<span foreground='#89b4fa'> </span> Hyprland";

					# == Terminal ==

					"sejjy@archlinux:(.*)" = "  $1";
					"(.*)sejjy@archlinux:~" = "  sejjy@archlinux";

					# == Browser ==

					"(.*) — Mozilla Firefox" =
						"<span foreground='#f38ba8'>󰈹 </span> $1"; 
					"(.*)Mozilla Firefox" =
						"<span foreground='#f38ba8'>󰈹 </span> Firefox";

					# == Development ==

					"(.*) - Visual Studio Code" =
						"<span foreground='#89b4fa'>󰨞 </span> $1";
					"(.*)Visual Studio Code" = 
						"<span foreground='#89b4fa'>󰨞 </span> Visual Studio Code";

					"Godot" = 
						"<span foreground='#89b4fa'> </span> Godot Engine";
					"Godot Engine - (.*)" = 
						"<span foreground='#89b4fa'> </span> $1";
					"(.*) - Godot Engine" = 
						"<span foreground='#89b4fa'> </span> $1";

					# == Media ==

					"(.*)Spotify" =
						"<span foreground='#a6e3a1'> </span> Spotify";
					"(.*)Spotify Premium" = 
						"<span foreground='#a6e3a1'> </span> Spotify Premium";

					"OBS(.*)" = 
						"<span foreground='#a6adc8'>󰐌 </span> OBS Studio";

					"VLC media player" = 
						"<span foreground='#fab387'>󰕼 </span> VLC Media Player";
					"(.*) - VLC media player" = 
						"<span foreground='#fab387'>󰕼 </span> $1";

					"GNU Image Manipulation Program" =
						"<span foreground='#a6adc8'> </span> GNU Image Manipulation Program";

					"qView" = "  qView";

					"(.*).jpg" = "  $1.jpg";
					"(.*).png" = "  $1.png";
					"(.*).svg" = "  $1.svg";

					# == Social ==

					"vesktop" =
						"<span foreground='#89b4fa'> </span> Discord";

					"• Discord(.*)" = "Discord$1";
					
					"(.*)Discord(.*)" = 
						"<span foreground='#89b4fa'> </span> $1Discord$2";

					# == Documents ==

					"ONLYOFFICE Desktop Editors" =
						"<span foreground='#f38ba8'> </span> OnlyOffice Desktop";

					"(.*).docx" =
						"<span foreground='#89b4fa'> </span> $1.docx";
					"(.*).xlsx" =
						"<span foreground='#a6e3a1'> </span> $1.xlsx";
					"(.*).pptx" =
						"<span foreground='#fab387'> </span> $1.pptx";
					"(.*).pdf" = 
						"<span foreground='#f38ba8'> </span> $1.pdf";

					"/" = "  File Manager";

					# == System ==

					"Timeshift-gtk" =
						"<span foreground='#a6e3a1'> </span> Timeshift";

					"Authenticate" = "  Authenticate";
				};
			};

			"custom/cpuinfo" = {
				"exec" = "~/.config/waybar/scripts/cpuinfo.sh";
			"return-type" = "json";
			"format" = "{}";
			"tooltip" = true;
			"interval" = 5;
			"min-length" = 8;
			"max-length" = 8;
			};

			"memory" = {
				"states" = {
					"warning" = 75;
					"critical" = 90;
				};

				"format" = "󰘚 {percentage}%";
				"format-critical" = "󰀦 {percentage}%";
				"tooltip" = true;
				"tooltip-format" = "Memory Used: {used:0.1f} GB / {total:0.1f} GB";
				"interval" = 5;
				"min-length" = 7;
				"max-length" = 7;
			};

			"custom/cpu" = {
				"exec" = "~/.config/waybar/scripts/cpuusage.sh";
				"return-type" = "json";
				"tooltip" = true;
				"interval" = 5;
				"min-length" = 6;
				"max-length" = 6;
			};

			"idle_inhibitor" = {
				"format" = " ";
				"tooltip" = true;
				"tooltip-format-activated" = "Presentation Mode";
				"tooltip-format-deactivated" = "Idle Mode";
				"start-activated" = false;
				"timeout" = 5;
			};

			"clock#time" = {
				"format" =: "󱑂 {:%H:%M}";
				"tooltip" = true
				"tooltip-format" = "12-hour Format: {:%I:%M %p}";
				"min-length" = 8;
				"max-length" = 8;
			};

			"clock#date" = {
				"format" = "󰨳 {:%m-%d}";
				"tooltip-format" = "<tt>{calendar}</tt>";

				"calendar" = {
					"mode" = "month";
					"mode-mon-col" = 6;
					"on-click-right" = "mode";
					"format" = { "today" = "<span color='#f38ba8'><b>{}</b></span>" };
				},
				
				"actions" = { "on-click-right" = "mode" };
				"min-length" = 8;
				"max-length" = 8;
			};

			"custom/wifi": {
				"exec" = "~/.config/waybar/scripts/wifiinfo.sh";
				"return-type" = "json";

				#// in wifiinfo.sh, change "Wi-Fi" to "${essid}"
				#// to display network name
				"format" = "{}";
				"tooltip" = true;
				"on-click" = "~/.config/waybar/scripts/wifimenu.sh";
				"interval" = 1;
				"min-length" = 7;
				"max-length" = 7;
			};

			"custom/media" = {
				"exec" = "~/.config/waybar/scripts/mediaplayer.py";
				"return-type" = "json";
				"format" = "{}";
				"tooltip" = "{tooltip}";
				"on-click" = "playerctl play-pause";
				"min-length" = 5;
				"max-length" = 35;
			};

			"pulseaudio" = {
				"format" = "{icon} {volume}%";
				"format-muted" = "󰝟 {volume}%";

				"format-icons" = {
					"headphone" = "󰋋";
					"default" = ["󰕿", "󰖀", "󰕾"];
				};

				"tooltip" = true;
				"tooltip-format" = "Device: {desc}";
				"on-click" = "~/.local/share/bin/volumecontrol.sh -o m";
				"on-scroll-up" = "~/.local/share/bin/volumecontrol.sh -o i";
				"on-scroll-down" = "~/.local/share/bin/volumecontrol.sh -o d";
				"min-length" = 6;
				"max-length" = 6;
			};

			"custom/backlight" = {
				"exec" = "~/.local/share/bin/brightnesscontrol.sh";
				"return-type" = "json";
				"format" = "{}";
				"tooltip" = true;
				"on-scroll-up" = "~/.local/share/bin/brightnesscontrol.sh -o i";
				"on-scroll-down" = "~/.local/share/bin/brightnesscontrol.sh -o d";
				"interval" = 1;
				"min-length" = 6;
				"max-length" = 6;
			};

			"battery" = {
				
				"states" = {
					"full" = 100;
					"good" = 99;
					"warning" = 30;
					"critical" = 15;
				};

				"format" = "{icon} {capacity}%";
				"format-icons" = ["󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂"];
				"format-full" = "󱃌 {capacity}%";
				"format-warning" = "󰁻 {capacity}%";
				"format-critical" = "󱃍 {capacity}%";
				"format-charging" = "󱘖 {capacity}%";
				"tooltip-format" = "Time to Empty: {time}"
				"tooltip-format-charging" = "Time to Full: {time}";
				"interval" = 1;
				"min-length" = 6;
				"max-length" = 6;
			};

			"custom/power" = {
				"format" = " ";
				"tooltip" = false;
				"on-click" = "~/.local/share/bin/logoutlaunch.sh 2";
				"on-click-right" = "~/.local/share/bin/logoutlaunch.sh 1";
				"interval" = 86400;
			};

			# === Padding ===

			"custom/paddw" = {
				"format" = " ";
				"tooltip" = false;
			};

			# adjust padding in style.css if you have a long network name
			# so that the modules remain centered.
			"custom/paddc" = {
				"format" = " ";
				"tooltip" = false;
			};

			# == Left Arrows ==

			"custom/left1" = {
				"format" = "";
				"tooltip" = false;
			};
			
			"custom/left2" = {
				"format" = "";
				"tooltip" = false;
			};
			
			"custom/left3" = {
				"format" = "";
				"tooltip" = false;
			};
			
			"custom/left4" = {
				"format" = "";
				"tooltip" = false;
			};
			
			"custom/left5" = {
				"format" = "";
				"tooltip" = false;
			};
			
			"custom/left6" = {
				"format" = "";
				"tooltip" = false;
			};

			"custom/left7" = {
				"format" = "";
				"tooltip" = false;
			};

			"custom/left8" = {
				"format" = "";
				"tooltip" = false;
			};

			# == Right Arrows==

			"custom/right1" = {
				"format" = "";
				"tooltip" = false;
			};
			
			"custom/right2" = {
				"format" = "";
				"tooltip" = false;
			};
			
			"custom/right3" = {
				"format" = "";
				"tooltip" = false;
			};
			
			"custom/right4" = {
				"format" = "";
				"tooltip" = false;
			};

			"custom/right5" = {
				"format" = "";
				"tooltip" = false;
			};

			# == Left Inverse ==

			"custom/leftin1" = {
				"format" = "";
				"tooltip" = false;
			};
			
			"custom/leftin2" = {
				"format" = "";
				"tooltip" = false;
			};

			# == Right Inverse ==

			"custom/rightin1": {
				"format" = "";
				"tooltip" = false;
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

			#bluetooth {
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
