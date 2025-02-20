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
      open = true;
      nvidiaSettings = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };



    graphics = {
      enable = true;
      enable32Bit = true;
    };




  };

    environment.systemPackages = with pkgs; [
      nvfancontrol
    ];

}
