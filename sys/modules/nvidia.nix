##############
### NVIDIA ###
##############

{
  config,
  pkgs,
  lib,
  ...
}:
{

  services.xserver.videoDrivers = [ "nvidia" ]; 
  hardware = {

    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };

  };
}
