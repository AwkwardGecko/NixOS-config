	
	###############
	### OPENRGB ###
	###############

	{ config, pkgs, lib, ... }:
{
	home.file = {
		".config/OpenRGB" = {
			source = ../config/OpenRGB;
			recursive = true;
		};
	};
}

