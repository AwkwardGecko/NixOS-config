{ config, lib, pkgs, ... }:
{
  services.flatpak.enable = true;

    system.activationScripts.addFlathubRemote.text = ''
    if ! flatpak remote-list | grep -q '^flathub'; then
      echo "Adding Flathub remote..."
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    fi
  '';
}
