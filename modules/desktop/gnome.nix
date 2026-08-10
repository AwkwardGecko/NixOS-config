{
  config,
  lib,
  pkgs,
  ...
}: {
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
    };
    displayManager = {
      gdm.enable = true;
      autoLogin = {
        enable = true;
        user = "zozano";
      };
    };
    desktopManager.gnome.enable = true;
  };

  home-manager.users.zozano = {
    gtk = {
      enable = true;
      iconTheme.package = pkgs.papirus-icon-theme;
      iconTheme.name = "Papirus";
    };
  };
}
