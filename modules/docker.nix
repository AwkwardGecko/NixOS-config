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
    enableOnBoot = true;
  };

  hardware = {

    nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
    nvidia.modesetting.enable = true;
    nvidia.open = false;
    nvidia-container-toolkit.enable = true;

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  users.users.zozano.extraGroups = [ "docker" ];
}
