# ~/.dotfiles/home-manager/modules/git.nix

{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Zozano";
        email = "private@private.com";
      };
      init.defaultBranch = "main";
    };
  };
}
