##############
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

	extraLuaConfig = ''
		require("ibl").setup()
		vim.o.termguicolors = true
		vim.cmd('colorscheme gruvbox')
		vim.g.gruvbox_material_background = 'hard'
	'';
  };
}
