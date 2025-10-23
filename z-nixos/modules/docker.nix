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
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  users.users.zozano.extraGroups = [ "docker" ];
}
