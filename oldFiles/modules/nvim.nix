
	##############
	### NEOVIM ###
	##############

	{ config, pkgs, lib, ... }:
{
	#home.file = {
	#	".config/nvim" = {
	#		source = ../config/nvim;
	#		recursive = true;
	#	};
	#};

	programs.neovim = {
		enable = true;
		defaultEditor = true;
		extraConfig = lib.fileContents ../config/nvim/init.lua;
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;
		plugins = with pkgs.vimPlugins; [
			gruvbox-nvim
			indent-blankline-nvim
			nvim-tree-lua
			lazygit-nvim
			nvim-treesitter.withAllGrammars
			nvim-treesitter-parsers.hyprlang
		];
	};
}
