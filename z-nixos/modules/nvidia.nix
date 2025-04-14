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
  ];
  
  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBGL_ALWAYS_INDIRECT = "0";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_VRR_ALLOWED = "1";
    export LIBGL_DRIVERS_PATH = /run/opengl-driver/lib/dri;
  };

}
