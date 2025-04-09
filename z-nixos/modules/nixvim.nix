{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;  # Gruvbox colorscheme

    plugins = {
      lualine.enable = true;               # Statusline plugin
      treesitter.enable = true;            # Advanced syntax highlighting
      telescope.enable = true;             # Fuzzy finder for files and more
      cmp.enable = true;                   # Autocompletion plugin
      web-devicons.enable = true;          # File icons for Neovim
      bufferline.enable = true;            # Buffer tabline for better navigation
      gitsigns.enable = true;              # Git integration in the editor
      comment.enable = true;               # Easy commenting of code
      nvim-autopairs.enable = true;             # Automatic pairing of parentheses and brackets
      indent-blankline.enable = true;      # Visual indentation guides
      fugitive.enable = true;              # Git commands inside Neovim
      
      plugin = [
        {
          name = "glepnir/dashboard-nvim";
          type = "git";
          url = "https://github.com/glepnir/dashboard-nvim";
        },
        
        {
          name = "preservim/nerdtree";
          type = "git";
          url = "https://github.com/preservim/nerdtree";
        },

        {
          name = "neovim/nvim-lspconfig";
          type = "git";
          url = "https://github.com/neovim/nvim-lspconfig";
        },

      ];
      
    };


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

