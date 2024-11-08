	
	#############
	### KITTY ###
	#############

	{ config, pkgs, lib, ... }:
{
	programs.kitty = {
		enable = true;
		environment = {
			shell = "fish";
		};
		#settings = {
		#	shell fish;
		#};
	};
	
	
	#home.file = {
	#	".config/kitty" = {
	#		source = ../config/kitty;
	#		recursive = true;
	#	};
	#};
}

