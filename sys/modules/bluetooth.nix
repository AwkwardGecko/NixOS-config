
	#################
	### BLUETOOTH ###
	#################

	{ config, pkgs, lib, ... }: {

	hardware.bluetooth.enable = true;
	services.blueman.enable = true;

	# environment.systemPackages = with pkgs; [
	#	bluez
	#	bluez-alsa
	#	bluez-tools
	# ];
}
