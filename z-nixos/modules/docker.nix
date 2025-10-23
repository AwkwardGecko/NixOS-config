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

    daemon.settings = {
      runtimes.nvidia.path = "${pkgs.nvidia-container-toolkit}/bin/nvidia-container-runtime";
      default-runtime = "nvidia";
    };
  };

  hardware = {
    
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
    nvidia-container-toolkit.enable = true;

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  users.users.zozano.extraGroups = [ "docker" ];
}
