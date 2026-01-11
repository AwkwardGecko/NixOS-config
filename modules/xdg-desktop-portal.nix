{
  pkgs,
  config,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [
      #pkgs.xdg-desktop-potal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  services.dbus.enable = true;

  xdg.mime = {
    enable = true;

    defaultApplications = {
      "inode/directory" = [ "nautilus.desktop" ];
    };
  };
}
