{ config, lib, pkgs, ... }:
{
  services.flatpak.enable = true;

  system.activationScripts.addFlathubRemote.text = ''
    if ! flatpak remote-list | grep -q '^flathub'; then
      echo "Adding Flathub remote..."
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      echo "Adding Honkai: Star Rail repository..."
      flatpak remote-add --if-not-exists --user launcher.moe https://gol.launcher.moe/gol.launcher.moe.flatpakrepo
      echo "Installing Gnome platform..."
      flatpak install org.gnome.Platform//45
      echo "Installing Honkai: Star Rail..."
      flatpak install launcher.moe moe.launcher.the-honkers-railway-launcher
    fi
  '';
}
