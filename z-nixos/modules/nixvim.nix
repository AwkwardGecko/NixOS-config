{ pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;

    plugins = {
      lualine.enable = true;
      treesitter.enable = true;
    };

    opts = {
      number = true;               # Enable line numbers
      relativenumber = true;       # Enable relative line numbers
      shiftwidth = 2;              # Set indentation width to 2 spaces
      tabstop = 2;                 # Set tab width to 2 spaces
      expandtab = true;            # Use spaces instead of tabs
      smartindent = true;          # Enable smart indentation
      autoindent = true;           # Enable automatic indentation
    };
}
