
	####################
	### AUTO UPGRADE ###
	####################

	{ config, pkgs, lib, ... }: {

	system.autoUpgrade = {
		enable = true;
		allowReboot = false;
	};
}
