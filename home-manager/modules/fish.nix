	
	############
	### FISH ###
	############

	{ config, pkgs, lib, ... }: {

	programs.fish = {
		enable = true;
		shellInitLast = "fastfetch";
	};

	programs.fastfetch.enable = true;
}
