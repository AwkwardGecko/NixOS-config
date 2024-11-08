
	################
	### HYPRLAND ###
	################

	{ config, pkgs, lib, ... }:
{
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};
}
