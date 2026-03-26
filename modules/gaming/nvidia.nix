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

  services.xserver = {
    #enable = true;
    videoDrivers = [ "nvidia" ];
  };

  hardware = {

    nvidia = {
      modesetting.enable = true;
      #open = true;
      open = false;
      nvidiaSettings = true;
      #nvidia-container-toolkit.enable = false;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };

    # nvidia-container-toolkit.enable = true;

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  environment.systemPackages = with pkgs; [
    clinfo
    libGL
    libglvnd
    mesa
    vulkan-tools
    vulkan-loader
    dxvk
    nvfancontrol
    lm_sensors
    mesa-demos #glxinfo # Collection of demos and test programs for OpenGL and Mesa
  ];

  # services.xserver.deviceSection = ''
  #   Option "Coolbits" "4"
  # '';
  #
  # environment.etc."X11/xorg.conf.d/11-nvidia-coolbits.conf".text = ''
  #   Section "Device"
  #     Identifier "Nvidia Card"
  #     Driver "nvidia"
  #     Option "Coolbits" "4"
  #   EndSection
  # '';

  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
}
