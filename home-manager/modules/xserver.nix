
	################
	### X-SERVER ###
	################

	{ config, pkgs, lib, ... }: {

	services.xserver = {
		
		enable = true;
		videoDrivers = [ "nvidia" ];
		
		xkb = {
			layout = "us";
			variant = "";
		};
	};
}
