{ config, pkgs, lib, ... }:
{
  services.gvfs.enable = true;
  environment = {
    pathsToLink = [ "share/thumbnailers" ];
    systemPackages = with pkgs; [
      btrfs-progs
      parted
      gparted
      gnome-disk-utility
    ];
  };
  
  home-manager.users.zozano = {
    home.packages = with pkgs; [
      baobab
      cryptsetup
    ];
  };
}
