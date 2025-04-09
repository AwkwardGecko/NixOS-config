{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    colorscheme = "gruvbox";  # Set the colorscheme to gruvbox

    plugins = {
      lualine.enable = true;
      treesitter.enable = true;
    };

    extraConfigVim = ''
      " Use vim-plug for plugin management
      call plug#begin('~/.vim/plugged')

      " Add gruvbox plugin
      Plug 'gruvbox-community/gruvbox'

      " End plugin installation
      call plug#end()

      " Additional Vim settings
      set number
      set relativenumber
      colorscheme gruvbox  # Ensure the colorscheme is set correctly
    '';
  };
}

