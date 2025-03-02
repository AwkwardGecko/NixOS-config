{ config, pkgs, lib, ... }:

{
  hardware.sane.enable = true;
  users.users.zozano.extraGroups = [
    "scanner"
    "lp"
  ];
  environment.systemPackages = with pkgs; [
    simple-scan
  ];
}
