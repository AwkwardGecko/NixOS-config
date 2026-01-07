################
### HYPRLAND ###
################

{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.displayManager.sddm.wayland.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];

  services.udisks2.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
      LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
}
