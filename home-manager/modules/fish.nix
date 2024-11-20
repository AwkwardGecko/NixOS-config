	
	############
	### FISH ###
	############

	{ config, pkgs, lib, ... }: {

	programs.fish = {
		enable = true;
		shellInit = "cd .dotfiles/";
		shellInitLast = "fastfetch";
		plugins = with pkgs.fishPlugins; = [
			gruvbox
		];
	};

	programs.fastfetch.enable = true;
}
