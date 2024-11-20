	
	############
	### FISH ###
	############

	{ config, pkgs, lib, ... }: {

	programs.fish = {
		enable = true;
		shellInit = "cd .dotfiles/";
		shellInitLast = "fastfetch";
		plugins = {
			gruvbox
		}
	};

}
