{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    colorscheme = "gruvbox";
    plugins = {
      lualine.enable = true;
      treesitter.enable = true;
	{
          name = "gruvbox-community/gruvbox";
          type = "git";
          url = "https://github.com/gruvbox-community/gruvbox";
        }
    };
    extraConfigVim = ''
      set number
      set relativenumber
    '';
  };
}

