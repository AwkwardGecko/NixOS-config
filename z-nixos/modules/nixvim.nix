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
The error you're seeing is because of a small mistake in the syntax. In Nix, when you define an attribute set, the last element doesn't need a comma. In your case, the error is likely caused by having an unnecessary comma after the last plugin definition inside the list.

Here’s how to fix it:

### Corrected Code:

```nix
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
      autopairs.enable = true;             # Automatic pairing of parentheses and brackets
      indent-blankline.enable = true;      # Visual indentation guides
      fugitive.enable = true;              # Git commands inside Neovim

      # Manually add plugins like nvim-lspconfig, dashboard-nvim, and nerdtree
      plugin = [
        {
          name = "neovim/nvim-lspconfig";
          type = "git";
          url = "https://github.com/neovim/nvim-lspconfig";
        }
        {
          name = "glepnir/dashboard-nvim";
          type = "git";
          url = "https://github.com/glepnir/dashboard-nvim";
        }
        {
          name = "preservim/nerdtree";
          type = "git";
          url = "https://github.com/preservim/nerdtree";
        }
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
```

### Key Fix:
- Removed the **comma** after the last plugin definition in the `plugin` list. In Nix, there should be no trailing commas after the last element in a list or an attribute set.

### Explanation:
- In the `plugin` list, the last plugin (`nerdtree`) shouldn’t have a comma after it. Nix expects the last item in a list or set to not be followed by a comma, as this leads to the "unexpected ','" error.

With that change, you should no longer see the error. Let me know if it

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

