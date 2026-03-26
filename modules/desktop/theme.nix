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
    atk
    cairo
    pango
    glib
    expat
  ];

  environment.sessionVariables = {
    GTK_THEME = "Adwaita";
  };
}
