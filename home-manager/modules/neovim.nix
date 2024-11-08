############
### NEOVIM ###
##############

{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.neovim = {

	enable = true;
	defaultEditor = true;
	viAlias = true;
	vimAlias = true;
	vimdiffAlias = true;
	
	plugins = with pkgs.vimPlugins; [
		indent-blankline-nvim
		gruvbox-nvim
		gruvbox-material-nvim
	];

	# extraConfig = ''
	#	foo
	# '';

	# e
	extraLuaConfig = ''
		require("ibl").setup()
		vim.g.mapleader = ' '
		vim.g.maplocalleader = ' '
		vim.o.clipboard = 'unnamedplus'
		vim.o.number = true
		vim.o.signcolumn = 'yes'
		vim.o.tabstop = 4
		vim.o.shiftwidth = 4
		vim.o.updatetime = 300
		vim.o.mouse = 'a'
		vim.o.termguicolors = true
		vim.cmd('colorscheme gruvbox-material')
		vim.g.gruvbox_material_background = 'hard'
	'';
  };
}
