	
	############
	### FISH ###
	############

	{ config, pkgs, lib, ... }: {

	programs.fish = {
		enable = true;
		shellInit = "cd .dotfiles/";
		shellInitLast = "fastfetch";
	};

	programs.fastfetch.enable = true;
}
