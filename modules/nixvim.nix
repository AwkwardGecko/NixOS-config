{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;
    opts = {
    	number = true;
	relativenumber = true;
	wrap = false;
	clipboard = "unnamedplus";
    };
    plugins = {
      lualine.enable = true;
      treesitter.enable = true;
      comment.enable = true;
      nvim-autopairs.enable = true;
    };
    lsp = {
    	enable = true;
	servers = {
		nil_ls.enable = true;
	};
    };
  };
}
