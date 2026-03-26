{
  pkgs,
  lib,
  config,
  ...
}:

{
  # Set up a global .gitignore to ignore dotfiles
  environment.etc."gitconfig".text = ''
    [core]
      excludesFile = ~/.gitignore_global
  '';

  # Ensure .gitignore_global file exists with the correct pattern
  environment.etc."gitignore_global".source = pkgs.writeText "gitignore_global" ''
    .*
  '';

  home-manager.users.zozano = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Zozano";
          email = "private@private.com";
        };
      init.defaultBranch = "main";
      };
      signing.format = "openpgp";
    };
  };
}
