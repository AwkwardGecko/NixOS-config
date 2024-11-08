	
	############
	### MAKO ###
	############

	{ config, pkgs, lib, ... }: {
	
	services.mako = {
		enable = true; # notification daemon
		backgroundColor = "#${config.colorScheme.palette.base01}";
		borderColor = "#${config.colorScheme.palette.base0E}";
		borderRadius = 5;
		borderSize = 2;
		textColor = "#${config.colorScheme.palette.base04}";
		layer = "overlay";
	};
}
