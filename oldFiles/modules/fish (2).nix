
	############
	### FISH ###
	############

	{ config, pkgs, lib, ... }:
{
	programs.fish = {
		enable = true;
		#plugins = with pkgs.fishPlugins; [
		#	gruvbox
		#];
	};

	#home.file = {
	#	".config/fish" = {
	#		source = ../config/fish;
	#		recursive = true;
	#	};
	#};
}
