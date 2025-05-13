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
      defaultTimeout = "2";
      icons = true;
      font = "JetBrainsMono-Regular";
      borderRadius = "15";
      borderSize = "2";
      layer = "overlay";
    };
  };
}
