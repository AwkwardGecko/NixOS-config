{ config, lib, pkgs, ... }:
{
  home-manager.users.zozano = {
    home.packages = with pkgs; [
    ];
  };
}
