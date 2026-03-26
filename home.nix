{ config, lib, inputs, pkgs, ... }:
{
  # imports = [
  # ]; import via configuration.nix module with home-manager.users.zozano = {};

  # home.packages = with pkgs; [
  # ]; import via home-packages.nix module


  home = {
    username = "zozano";
    homeDirectory = "/home/zozano";
    stateVersion = "24.05"; # never change
    enableNixpkgsReleaseCheck = false;

    sessionVariables = {
      SDL_VIDEODRIVER = "wayland"; # Wayland backends for common stacks
      QT_QPA_PLATFORM = "wayland";
      MOZ_ENABLE_WAYLAND = 1;
      NIXOS_OZONE_WL = 1; # Enables Wayland (Ozone) backend in Chromium/Electron apps.
      ELECTRON_OZONE_PLATFORM_HINT = "auto";

      LIBVA_DRIVER_NAME = "nvidia"; # VA-API hardware video decode backend.
      __GLX_VENDOR_LIBRARY_NAME = "nvidia"; # Tells GLVND (OpenGL vendor dispatcher) to use Nvidia’s driver instead of Mesa’s.

      # Wine / Proton
      #WINE_FULLSCREEN_FOCUS_MODE = 1; # Lets Wine maintain focus properly when alt-tabbing fullscreen games under Wayland.

      # Portals & theming (Wayland-friendly file pickers, etc.)
      #GTK_USE_PORTAL = 1;
      #QT_QPA_PLATFORMTHEME = "qt5ct";

      SDL_AUDIODRIVER = "pipewire";
    };
  };

  systemd.user.startServices = "sd-switch";
  programs.home-manager.enable = true;

}
