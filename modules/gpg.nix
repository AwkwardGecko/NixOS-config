{
  pkgs,
  lib,
  config,
  ...
}:
{
  home-manager.users.zozano = {
    programs.gpg.enable = true;
  };
}
