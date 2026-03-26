{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.kdeconnect.enable = true;
  environment.systemPackages = with pkgs; [
    kdePackages.kio-extras
    gvfs
    libmtp
  ];
}
