##############
### DOCKER ###
##############

{
  config,
  pkgs,
  lib,
  ...
}:
{
  virtualisation.docker = {
    enable = true;
  };

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
  hardware.nvidia-container-toolkit.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

  users.users.zozano.extraGroups = [ "docker" ];
}
