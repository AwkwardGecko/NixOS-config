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

   services.mbpfan = {
      enable = true;
      settings = {
         general = {
            low_temp = 55;
            high_temp = 58;
            max_temp = 65;
            polling_interval = 1;
         };
      };
   };


  services.xserver = {
     enable = true;
     videoDrivers = [ "nvidia" ];
  };

  hardware = {

    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      powerManagement.enable = false;
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
    gwe
  ];
  
  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

}
