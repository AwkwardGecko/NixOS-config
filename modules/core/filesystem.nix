##################
### FILESYSTEM ###
##################

{
  config,
  pkgs,
  lib,
  ...
}:
{

  services.gvfs.enable = true;

  environment.pathsToLink = [ "share/thumbnailers" ];
}
