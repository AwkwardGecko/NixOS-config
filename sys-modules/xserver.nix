################
### X-SERVER ###
################

{
  config,
  pkgs,
  lib,
  ...
}:
{

  services.displayManager.sddm.wayland.enable = true;

  services.xserver = {

    enable = true;
    videoDrivers = [ "nvidia" ];

    xkb = {
      layout = "us";
      variant = "";
    };
  };
}
