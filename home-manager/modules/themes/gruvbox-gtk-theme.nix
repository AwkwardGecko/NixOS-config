
	###############
	### GRUVBOX ###
	###############

	{ config, pkgs, lib, ... }: {

	gtk.theme = {
		name = "Gruvbox";
		package = pkgs.gruvbox-gtk-theme;
	};
}
