{ pkgs, self, ... }: {
  
  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    performance.byteCompileLua.enable = true;
    clipboard.providers.wl-copy.enable = true;
    colorschemes.gruvbox.enable = true;  # Gruvbox colorscheme

    extraConfigLua = ''
      -- persistent flag
      vim.g.format_enabled = true

      vim.api.nvim_create_user_command("ToggleFormat", function()
        vim.g.format_enabled = not vim.g.format_enabled
        vim.b.autoformat = vim.g.format_enabled  -- conform uses this in 1.0
        require("notify")(
          (vim.g.format_enabled and "Enabled" or "Disabled") .. " formatting"
        )
      end, { desc = "Toggle autoformat-on-save" })
    '';


      # old extraConfigLua
      # local format_enabled = true
      # vim.api.nvim_create_user_command(
      #   "ToggleFormatNotified",
      #   function()
      #   if format_enabled then
      #     vim.cmd("FormatDisable")
      #     require("notify")("Disabled formatting")
      #     format_enabled = false
      #   else
      #     vim.cmd("FormatEnable")
      #     require("notify")("Enabled formatting")
      #     format_enabled = true
      #     end
      #   end,
      #   {}
      # )

    plugins = {
    
      luasnip.enable = true;

      dap.enable = true;
      dap-ui.enable = true;

      copilot.enable = true;

      cmp = {
        enable = true;
        sources = [ "luasnip" "nvim_lsp" "buffer" "path" "copilot" ];
        autoEnableSources = true;
      };
      
      lsp = {
        enable = true;
        servers = {
          lua_ls.enable = true;
          #ts_ls.enable = true;
          tsserver.enable = true;
          nil_ls.enable = true;
          cssls.enable = true;
          html.enable = true;
          bashls.enable = true;
          pylsp.enable = true;
        };
      };

      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            lspFallback = true;
            timeoutMs = 500;
          };
        };
      };

      notify.enable = true;
      lualine.enable = true;               # Statusline plugin
      treesitter.enable = true;            # Advanced syntax highlighting
      telescope.enable = true;             # Fuzzy finder for files and more
      web-devicons.enable = true;          # File icons for Neovim
      bufferline.enable = true;            # Buffer tabline for better navigation
      gitsigns.enable = true;              # Git integration in the editor
      comment.enable = true;               # Easy commenting of code
      nvim-autopairs.enable = true;             # Automatic pairing of parentheses and brackets
      indent-blankline.enable = true;      # Visual indentation guides
      #lightline.enable = true;
      fugitive.enable = true;              # Git commands inside Neovim
    };

    opts = {
      number = true;                       # Show absolute line numbers
      shiftwidth = 2;                      # Set indentation width to 2 spaces
      tabstop = 2;                         # Set tab width to 2 spaces
      softtabstop = 2;
      expandtab = true;                    # Use spaces instead of tabs
      smartindent = true;                  # Enable smart indentation
      #autoindent = true;                   # Enable automatic indentation
      clipboard = "unnamedplus";
    };
  };
}

