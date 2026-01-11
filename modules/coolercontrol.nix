{
  config,
  lib,
  pkgs,
  ...
}:
{

  programs.coolercontrol.enable = true;

  environment.systemPackages = with pkgs; [
    lm_sensors
    liquidctl
  ];
}
