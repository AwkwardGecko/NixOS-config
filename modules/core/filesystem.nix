{
  config,
  pkgs,
  lib,
  ...
}: {
  services.gvfs.enable = true;

  services.fstrim.enable = true;

  environment = {
    systemPackages = with pkgs; [
      btrfs-progs
      parted
      freefilesync
      czkawka-full
      gparted
      gnome-disk-utility
      baobab
      cryptsetup
    ];
  };

  # home-manager.users.zozano = {
  #   home.packages = with pkgs; [
  #     baobab
  #     cryptsetup
  #   ];
  # };
}
