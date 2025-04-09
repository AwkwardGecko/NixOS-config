{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    colorscheme = "gruvbox";
    plugins = {
      lualine.enable = true;
      treesitter.enable = true;
    };
    extraConfigVim = ''
      set number
      set relativenumber
    '';
  };
}

