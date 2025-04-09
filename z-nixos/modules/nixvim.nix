{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;

    plugins = {
      # Enable lualine and treesitter as plugins
      lualine.enable = true;
      treesitter.enable = true;
    };


    extraConfigVim = ''
      " Enable line numbers
      set number           " Show absolute line numbers
      set relativenumber   " Show relative line numbers

      " Enable line indentation
      set tabstop=4        " Set tab width to 4 spaces
      set shiftwidth=4     " Indentation width
      set expandtab        " Use spaces instead of tabs
      set smartindent      " Enable smart indentation
      set autoindent       " Enable automatic indentation

      " Ensure the colorscheme is applied correctly
      colorscheme gruvbox  # Set the gruvbox colorscheme
    '';
  };
}

