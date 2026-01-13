{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;
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
