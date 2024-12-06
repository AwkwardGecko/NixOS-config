############
### FISH ###
############

{
  config,
  pkgs,
  lib,
  ...
}:
{

  programs.fish = {
    enable = true;
    shellInit = "cd ~/.dotfiles/";
    shellInitLast = "fastfetch";
    plugins = [
      {
        name = "gruvbox";
        src = pkgs.fishPlugins.gruvbox.src;
      }
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
    ];
  };

}
