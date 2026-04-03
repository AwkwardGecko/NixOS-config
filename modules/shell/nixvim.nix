{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;

    extraPackages = [
      pkgs.tree-sitter
      pkgs.nil
    ];

    opts = {
      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 2;
      smartindent = true;
      expandtab = true;
      number = true;
      relativenumber = true;
      wrap = false;
      clipboard = "unnamedplus";
    };

    #extraConfigLuaPre = ''
    #  vim.opt.runtimepath:append(vim.fn.stdpath('data') .. '/site')
    #'';

    plugins = {
      lualine.enable = true;
      comment.enable = true;
      nvim-autopairs.enable = true;

      treesitter = {
        enable = true;
        nixGrammars = true;
      };

      lsp = {
        enable = true;
        inlayHints = true;
        autoLoad = true;
        servers = {
          nil_ls = {
            enable = true;
            settings = {
              formatting.command = ["nixpkgs-fmt"];
              nix.flake.autoArchive = true;
              nixos.options.enable = true;
              home-manager.options.enable = true;
            };
          };
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
      };
    };
  };
}
