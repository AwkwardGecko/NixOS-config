{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    signal-desktop
    signal-export
  ];

  imports = [
    ./signal-read-notify.nix
  ];

  services.signal-read-notify.enable = true;
}
