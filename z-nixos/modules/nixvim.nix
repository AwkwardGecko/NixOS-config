{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    colorscheme = "gruvbox";
    plugins = {
      lualine.enable = true;
      treesitter.enable = true;
	plugin = [
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

