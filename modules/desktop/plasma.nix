# ~/.dotfiles/modules/desktop/plasma.nix
{
  config,
  pkgs,
  lib,
  ...
}: {
  services = {
    desktopManager.plasma6.enable = true;

    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      autoLogin = {
        enable = true;
        user = "zozano";
      };
    };
    udisks2.enable = true;
    dbus.enable = true;
  };

  environment.systemPackages = with pkgs; [
    xdg-user-dirs
    libmtp
    wl-clipboard
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  home-manager.users.zozano = {
    home.packages = with pkgs; [
      cliphist
    ];

    services.kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}
