#############
### KITTY ###
#############

{
  config,
  pkgs,
  lib,
  ...
}:
{

  fonts.packages = with pkgs; [
    jetbrains-mono
  ];

  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;

    settings = {
      shell = "fish";
    };

    font = {
      name = "JetBrains Mono";
      size = 12;
    };

    themeFile = "GruvboxMaterialDarkMedium";
  };
}
