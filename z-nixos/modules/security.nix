{ config, lib, pkgs, ... }:
{
  services.gnome.gnome-keyring.enable = true;

  security.pam.services = {
    login.enableGnomeKeyring = true;
  };
}
