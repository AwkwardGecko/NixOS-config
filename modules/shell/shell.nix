{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bc
    gawk
    jq
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
}
