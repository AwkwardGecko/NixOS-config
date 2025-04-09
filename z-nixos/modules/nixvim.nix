{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    colorscheme = "gruvbox";  # Set the colorscheme to gruvbox

    plugins = {
      lualine.enable = true;
      treesitter.enable = true;
    };

    extraConfigVim = ''
      " Ensure packer is installed
      if empty(glob('~/.local/share/nvim/site/pack/packer/start/packer.nvim'))
        silent !git clone --depth 1 https://github.com/wbthomason/packer.nvim \
            ~/.local/share/nvim/site/pack/packer/start/packer.nvim
      endif

      " Initialize packer
      lua << EOF
        require('packer').startup(function(use)
          use 'gruvbox-community/gruvbox'  -- Add the gruvbox plugin
          use 'nvim-lualine/lualine.nvim'  -- lualine plugin
          use 'nvim-treesitter/nvim-treesitter'  -- treesitter plugin
        end)
      EOF

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

