
	############
	### ROFI ###
	############

	{ config, pkgs, lib, ... }:
{
	programs.rofi-wayland = {
		enable = true;
	}
