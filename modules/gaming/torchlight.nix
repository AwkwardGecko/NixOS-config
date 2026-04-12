# ~/.dotfiles/z-nixos/modules/torchlight-saves.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.zozano = {
    xdg.desktopEntries = {
      torchlight-save = {
        name = "Torchlight Save";
        exec = "/home/zozano/.dotfiles/scripts/torchlight-save.sh";
        terminal = false;
        type = "Application";
        categories = ["Game"];
      };
      torchlight-load = {
        name = "Torchlight Load";
        exec = "/home/zozano/.dotfiles/scripts/torchlight-load.sh";
        terminal = false;
        type = "Application";
        categories = ["Game"];
      };
    };
  };
}
