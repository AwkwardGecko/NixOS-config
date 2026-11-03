{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.zozano = {
    programs.pandoc.enable = true;
  };
}
