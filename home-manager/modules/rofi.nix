
	############
	### ROFI ###
	############

	{ config, pkgs, lib, ... }:
{
	programs.rofi = {
		enable = true;
		
		extraConfig = {
			#
		};

		plugins = with pkgs; [
			#
		];
	};
}
