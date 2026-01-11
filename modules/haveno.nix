{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    openjdk21
  ];

  programs.java = {
    enable = true;
    package = pkgs.openjdk21;
  };
}
