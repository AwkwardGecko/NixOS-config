{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    signal-desktop
    signal-export
  ];

  nixpkgs.config.allowBroken = true;
}
