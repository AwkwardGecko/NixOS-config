{
  config,
  lib,
  pkgs,
  ...
}:
{
home-manager.users.zozano = {
xdg.desktopEntries."moe.launcher.the-honkers-railway-launcher" = {
    name = "Honkai: Star Rail";
    exec = "flatpak run --branch=stable --arch=x86_64 --command=moe.launcher.the-honkers-railway-launcher moe.launcher.the-honkers-railway-launcher";
    icon = "moe.launcher.the-honkers-railway-launcher";
    comment = "Honkai: Star Rail";
    categories = [ "Game" ];
    terminal = false;
  };
  };
}
