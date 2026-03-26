{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bc
    gawk
    jq
    fclones
    lsof
    unzip
    inotify-tools
    bootiso
    libnotify
    btop
  ];

  environment.extraInit = ''
    export PATH="$HOME/.local/bin:$PATH"
  '';

  home-manager.users.zozano = {
    home.packages = with pkgs; [
      dex
      fastfetch
      grc
      htop
      fclones
      ripgrep
    ];
  };
}
