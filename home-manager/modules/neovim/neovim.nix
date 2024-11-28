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
		comment-nvim # Vimjoyer recommended

		cmp_luasnip # Vimjoyer recommended
		cmp-nvim-lsp # Vimjoyer recommended

		indent-blankline-nvim

		gruvbox-material-nvim

		gruvbox-nvim

		lualine-nvim

		nvim-cmp # Vimjoyer recommended

		nvim-tree-lua
		nvim-web-devicons
		
		nvim-lspconfig # Vimjoyer recommended
		
		nvim_luasnip # Vimjoyer recommended
		friendly-snippets

		telescope-nvim
		telescope-fzf-native-nvim
		
		vim-nix

		(nvim-treesitter.withPlugins (p: [
			p.tree-sitter-nix
			p.tree-sitter-vim
			p.tree-sitter-bash
			p.tree-sitter-fish
			p.tree-sitter-lua
			p.tree-sitter-python
			p.tree-sitter-json
		]))

	];

	# extraConfig = ''
	#	foo
	# '';

	# 
	extraLuaConfig = ''

		${builtins.readFile ./neovim/options.lua}

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
