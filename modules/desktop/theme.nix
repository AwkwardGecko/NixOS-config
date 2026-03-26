#~/.dotfiles/z-nixos/modules/theme.nix
{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    hicolor-icon-theme
    libadwaita
    qt5.qtwayland
    qt6Packages.qt6ct
  ];

  environment.sessionVariables = {
    GTK_THEME = "Adwaita";
  };
}
