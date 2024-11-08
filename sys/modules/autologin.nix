
	##################
	### AUTO LOGIN ###
	##################

	{ config, pkgs, lib, ... }:
{
	services.displayManager.autoLogin = {
		enable = true;
		user = "zozano";
	};
}
