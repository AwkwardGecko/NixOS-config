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
    package = pkgs.mako;
    settings = {
      actions = true;
      anchor = "top-right";
      background-color = "#000000CC";
      border-color = "#FFFFFF";
      border-radius = 0;
      default-timeout = 0;
      height = 100;
      width = 300;
      icons = true;
      ignore-timeout = false;
      layer = "top";
      margin = 10;
      markup = true;
      defaultTimeout = 20;
      font = "JetBrainsMono 10";

      urgency-low = {
        border-color = "#444444";
      };

      urgency-normal = {
        border-color = "#888888";
      };

      urgency-critical = {
        border-color = "#FF0000";
        default-timeout = 0; # stay until dismissed
      };
    };
  };
}
