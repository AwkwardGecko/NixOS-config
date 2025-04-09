{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    colorscheme = "gruvbox";  # Set the colorscheme to gruvbox

    plugins = {
      lualine.enable = true;
      treesitter.enable = true;
    };

    extraConfigVim = ''
      " Install vim-plug if not already installed
      if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        " Wait a bit for the plugin manager to install
        autocmd VimEnter * PlugInstall | source $MYVIMRC
      endif

      " Use vim-plug for plugin management
      call plug#begin('~/.vim/plugged')

      " Add gruvbox plugin
      Plug 'gruvbox-community/gruvbox'

      " End plugin installation
      call plug#end()

      " Enable line numbers
      set number           " Show absolute line numbers
      set relativenumber   " Show relative line numbers

      " Enable line indentation
      set tabstop=4        " Set tab width to 4 spaces
      set shiftwidth=4     " Indentation width
      set expandtab        " Use spaces instead of tabs
      set smartindent      " Enable smart indentation
      set autoindent       " Enable automatic indentation

      " Additional Vim settings
      colorscheme gruvbox  # Ensure the colorscheme is set correctly
    '';
  };
}

