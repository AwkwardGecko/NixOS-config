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
    backgroundColor = "#${config.colorScheme.palette.base01}";
    #borderColor = "#${config.colorScheme.palette.base0E}";
    borderRadius = "15";
    borderSize = "2";
    textColor = "#${config.colorScheme.palette.base04}";
    layer = "overlay";
  };
}
