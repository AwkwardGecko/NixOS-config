{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    protonmail-bridge
    libnotify
  ];
}
