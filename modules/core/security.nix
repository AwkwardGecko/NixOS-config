{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  home-manager.users.zozano = {
    programs.gpg.enable = true;
  };

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.sshKeyPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
    ];
    secrets."headscale/desktop_key" = { };
  };

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
    
  polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
      		
      if (
      	subject.isInGroup("zozano")
      	&& (
      		action.id == "org.freedesktop.login1.reboot" ||
      		action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
      		action.id == "org.freedesktop.login1.power-off" ||
      		action.id == "org.freedesktop.login1.power-off-multiple-sessions"
      	)
      )
      		
      { return polkit.Result.YES; }

      if (subject.isInGroup("wheel"))
      	return polkit.Result.YES;
      });
    '';
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
