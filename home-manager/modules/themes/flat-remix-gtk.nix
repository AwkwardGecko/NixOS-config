
	######################
	### FLAT-REMIX-GTK ###
	######################

	{ config, pkgs, lib, ... }: {

	gtk.theme = {
		name = "Flat-Remix-GTK-Grey-Darkest";
		package = pkgs.flat-remix-gtk;
	};
}
