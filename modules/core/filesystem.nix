{
  config,
  pkgs,
  lib,
  ...
}: {
  services.gvfs.enable = true;
  environment = {
    systemPackages = with pkgs; [
      btrfs-progs
      parted
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
