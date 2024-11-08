
	###########
	### GTK ###
	###########

	{ config, pkgs, lib, ... }:
{
	gtk = {
		enable = true;
		
		theme = {
			#package = pkgs.flat-remix-gtk;
			#name = "Flat-Remix-GTK-Grey-Darkest";

			package = pkgs.gruvbox-gtk-theme;
			name = "Gruvbox";

			#package = pkgs.gruvbox-dark-gtk;
			#name = "Gruvbox Dark";
		};

		iconTheme = {
			#package = pkgs.papirus-icon-theme;
			#name = "Papirus";

			package = pkgs.gruvbox-plus-icons;
			name = "Gruvbox";

			#package = pkgs.adwaita-icon-theme;
			#name = "Adwaita";
		};

		font = {
			#name = "Sans";
			#size = 11;

			name = "Cantarell";
			size = 11;
		};
	};
}
