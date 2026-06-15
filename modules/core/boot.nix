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

  boot.plymouth.enable = true;
  boot.initrd.systemd.enable = true;

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
