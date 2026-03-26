#~/.dotfiles/z-nixos/modules/theme.nix
{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    libadwaita
    qt5.qtwayland
  ];

  environment.sessionVariables = {
    GTK_THEME = "Adwaita";
  };
}
