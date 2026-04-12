{ config, lib, pkgs, ... }:

{
  home-manager.users.zozano = {
    xdg.desktopEntries = {
      torchlight-save = {
        name = "Torchlight Save";
        exec = "${config.home.homeDirectory}/.dotfiles/scripts/torchlight-save.sh";
        terminal = true;
        type = "Application";
        categories = [ "Game" ];
      };
      torchlight-load = {
        name = "Torchlight Load";
        exec = "${config.home.homeDirectory}/.dotfiles/scripts/torchlight-load.sh";
        terminal = true;
        type = "Application";
        categories = [ "Game" ];
      };
    };
  };
}
