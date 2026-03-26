{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    age # generating keypairs
    seahorse #keyring manager
    libcap
    libsecret
    lynis
  ];

  services = {
    gnome.gnome-keyring.enable = true;
    gnome.gcr-ssh-agent.enable = false;
  };

  security = {
    doas.enable = true;
    pam.services = {
      login.enableGnomeKeyring = true;
    };
    sudo = {
      extraConfig = ''
        Defaults timestamp_timeout=-1
      ''; # removes time-out for running sudo commands
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
