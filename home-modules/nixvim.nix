{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    colorscheme = "onedark";
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

