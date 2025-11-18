############
### MAKO ###
############

{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  services.mako = {
    enable = true; # notification daemon
    settings = {
      actions = true;
      anchor = "top-right";
      background-color = "#000000CC";
      border-color = "#FFFFFF";
      border-radius = 0;
      default-timeout = 5000;
      height = 100;
      width = 300;
      icons = true;
      ignore-timeout = false;
      layer = "top";
      margin = 10;
      markup = true;
      font = "JetBrainsMono 10";
    };
  };
}
