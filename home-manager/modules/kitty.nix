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

  home.packages = with pkgs; [
    jetbrains-mono
  ];

  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    settings = {
      background_opacity = "0.4";
      background = "#000000";
    };

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
