{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;  # Gruvbox colorscheme

    plugins = [
      { name = "hoob3rt/lualine.nvim"; enable = true; }            # Statusline plugin
      { name = "nvim-treesitter/nvim-treesitter"; enable = true; }  # Advanced syntax highlighting
      { name = "nvim-telescope/telescope.nvim"; enable = true; }    # Fuzzy finder for files and more
      { name = "hrsh7th/nvim-cmp"; enable = true; }                 # Autocompletion plugin
      { name = "neovim/nvim-lspconfig"; enable = true; }            # Language Server Protocol integration
      { name = "kyazdani42/nvim-web-devicons"; enable = true; }     # File icons for Neovim
      { name = "akinsho/bufferline.nvim"; enable = true; }          # Buffer tabline for better navigation
      { name = "lewis6991/gitsigns.nvim"; enable = true; }          # Git integration in the editor
      { name = "numToStr/Comment.nvim"; enable = true; }            # Easy commenting of code
      { name = "windwp/nvim-autopairs"; enable = true; }            # Automatic pairing of parentheses and brackets
      { name = "lukas-reineke/indent-blankline.nvim"; enable = true; }  # Visual indentation guides
      { name = "preservim/nerdtree"; enable = true; }               # File explorer plugin
      { name = "tpope/vim-fugitive"; enable = true; }               # Git commands inside Neovim
      { name = "glepnir/dashboard-nvim"; enable = true; }            # Start screen with shortcuts and session info
    ];

    opts = {
      number = true;                       # Show absolute line numbers
      relativenumber = true;               # Show relative line numbers
      shiftwidth = 2;                      # Set indentation width to 2 spaces
      tabstop = 2;                         # Set tab width to 2 spaces
      expandtab = true;                    # Use spaces instead of tabs
      smartindent = true;                  # Enable smart indentation
      autoindent = true;                   # Enable automatic indentation
    };
  };
}

