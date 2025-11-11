{ pkgs, config, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
  ];

  xdg.mime = {
    enable = true;

    defaultApplications = {
      "inode/directory" = [ "nautilus.desktop" ];
    };
  };
}
