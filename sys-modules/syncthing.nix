{ config, lib, pkgs, ... }:
{
  services.syncthing = {
    enable = true;
    group = "users";
    user = "zozano";
    dataDir = "/home/zozano/Documents/syncthing";
    configDir = "/home/zozano/.config/syncthing";
  };
}
