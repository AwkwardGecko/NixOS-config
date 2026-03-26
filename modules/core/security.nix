{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    seahorse #keyring
  ];

  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = false;

  security = {
    pam.services = {
      login.enableGnomeKeyring = true;
    };
    sudo = {
      extraConfig = ''
        Defaults timestamp_timeout=-1
      '';
      extraRules = [{
        users = [ "zozano" ];
        commands = [
          {
          command = "/run/current-system/sw/bin/nix-collect-garbage";
          options = [ "NOPASSWD" ];
          }
          {
          command = "/run/current-system/sw/bin/nixos-rebuild";
          options = [ "NOPASSWD" ];
          }
          {
          command = "/run/current-system/sw/bin/nix-store";
          options = [ "NOPASSWD" ];
          }
        ];
      }];
    };
  };
}
