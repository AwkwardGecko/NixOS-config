#############
### FONTS ###
#############

{
  config,
  pkgs,
  lib,
  ...
}:
{

  fonts.fontconfig.enable = true;

  fonts.packages = with pkgs; [


    #dina-font
    fira-code
    fira-code-symbols
    font-awesome
    #gyre-fonts
    jetbrains-mono
    liberation_ttf
    #ipafont
    mplus-outline-fonts.githubRelease
    nerd-fonts
    noto-fonts
    noto-fonts-emoji
    #noto-fonts-extra
    proggyfonts
    #ubuntu_font_famly
    #vazir-fonts
  ];++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts)
}
