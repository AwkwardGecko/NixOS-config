{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.zozano = {
    programs.lutris = {
      enable = true;
      protonPackages = [
        "pkgs.proton-ge-bin"
      ];
    };
  };
}
