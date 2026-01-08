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
  ];

  environment.sessionVariables = {
    GTK_THEME = "Adwaita";
  };
}
