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
    defaultTimeout = "2";
    icons = true;
    font = "monospace";
    borderRadius = "15";
    borderSize = "2";
    layer = "overlay";
  };
}
