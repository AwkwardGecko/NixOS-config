{
  config,
  pkgs,
  lib,
  ...
}:
{
  home-manager.users.zozano = { 
  programs.rofi = {
    enable = true;

    extraConfig = {
      #
    };

    plugins = with pkgs; [
      #
    ];
  };
  };
}
