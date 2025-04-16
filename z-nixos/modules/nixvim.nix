{ pkgs, self, ... }: {
  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;  # Gruvbox colorscheme

    plugins = {
      lualine.enable = true;               # Statusline plugin
      treesitter.enable = true;            # Advanced syntax highlighting
      telescope.enable = true;             # Fuzzy finder for files and more
      web-devicons.enable = true;          # File icons for Neovim
      bufferline.enable = true;            # Buffer tabline for better navigation
      gitsigns.enable = true;              # Git integration in the editor
      comment.enable = true;               # Easy commenting of code
      nvim-autopairs.enable = true;             # Automatic pairing of parentheses and brackets
      indent-blankline.enable = true;      # Visual indentation guides
      fugitive.enable = true;              # Git commands inside Neovim
    };

    opts = {
      number = true;                       # Show absolute line numbers
      relativenumber = true;               # Show relative line numbers
      shiftwidth = 2;                      # Set indentation width to 2 spaces
      tabstop = 2;                         # Set tab width to 2 spaces
      expandtab = true;                    # Use spaces instead of tabs
      smartindent = true;                  # Enable smart indentation
      autoindent = true;                   # Enable automatic indentation
      sessionoptions = "buffers,curdir,folds,help,tabpages,winsize";  # Save session options
    };

    extraConfigLua = ''
      " Automatically save the session when Neovim exits
      autocmd VimLeavePre * silent! mksession! ~/.vim/sessions/default.vim

      " Automatically load the session when Neovim starts
      if filereadable(expand('~/.vim/sessions/default.vim'))
        source ~/.vim/sessions/default.vim
      endif
      
      " Key mappings
        nnoremap <C-S-c> "+y   " Ctrl+Shift+C to copy to clipboard
        nnoremap <C-S-v> "+p   " Ctrl+Shift+V to paste from clipboard
    '';
  };
}

