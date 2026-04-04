{
  config,
  pkgs,
  lib,
  ...
}: {
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.gvfs.enable = true;

  environment.systemPackages = with pkgs; [
    btrfs-progs
    parted
    gparted
    gnome-disk-utility
    baobab
    cryptsetup
  ];
}
