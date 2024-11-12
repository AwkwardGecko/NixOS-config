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
		nvim-lspconfig
		nvchad-ui
		nvchad
		nvim-tree-lua
		nvim-web-devicons
		gitsigns-nvim
		mason-nvim
		nvim-cmp
		nvim-autopairs
		snippets-nvim
		nvim-treesitter
		telescope-nvim
		which-key-nvim
		mason-lspconfig-nvim
		gruvbox-nvim
		gruvbox-material-nvim
	];

	# extraConfig = ''
	#	foo
	# '';

	# 
	extraLuaConfig = ''
		require("ibl").setup()
		vim.g.mapleader = ' '
		vim.g.maplocalleader = ' '
		vim.o.clipboard = 'unnamedplus'
		vim.o.number = true
		-- vim.o.relativenumber = true
		vim.o.signcolumn = 'yes'
		vim.o.tabstop = 4
		vim.o.shiftwidth = 4
		vim.o.updatetime = 300
		vim.o.mouse = 'a'
		vim.o.termguicolors = true
		vim.cmd('colorscheme gruvbox')
		vim.g.gruvbox_material_background = 'hard'
	'';
  };
}
