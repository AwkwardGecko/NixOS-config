{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    colorscheme = "gruvbox";
    plugins = {
      lualine.enable = true;
      treesitter.enable = true;
      gruvbox.enable = true;
    };
    extraConfigVim = ''
      set number
      set relativenumber
    '';
  };
}

