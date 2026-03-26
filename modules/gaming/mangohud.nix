{ config, lib, pkgs, ... }:
{
  home-manager.users.zozano = {
programs.mangohud = {
    enable = true;
    #settings = {

    #};
  };

};
}
