{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.zozano = {
    programs.gpg.enable = true;
  };

  imports = [inputs.sops-nix.nixosModules.sops];

  sops.defaultSopsFile = ../../secrets/secrets.yaml; # master
  sops.age.sshKeyPaths = [
    "/etc/ssh/ssh_host_ed25519_key" # machines private ssh key, used to decrypt secrets.yaml
  ];

  sops.secrets."ssh/home-server-key" = {};
  fileSystems."/server".options = ["IdentityFile=${config.sops.secrets."ssh/home-server-key".path}"];
  fileSystems."/data".options = ["IdentityFile=${config.sops.secrets."ssh/home-server-key".path}"];

  sops.secrets."tailscale/pre_auth_key" = {};
  services.tailscale.authKeyFile = config.sops.secrets."tailscale/pre_auth_key".path; # generated on z-home-mac

  users.users.zozano.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL+JLIMMkhZty4POE+gHXrNwy11myWa0F+nVsWeyYJE3 tim@solaire.com"];
  # allows remote client with this key to ssh into this computer

  environment.systemPackages = with pkgs; [
    age # generating keypairs
    seahorse #keyring manager
    libcap
    libsecret
    lynis
    sops
    ssh-to-age
    cryptsetup
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
      extraRules = [
        {
          users = ["zozano"];
          commands = [
            {
              command = "/run/current-system/sw/bin/nix-collect-garbage";
              options = ["NOPASSWD"];
            }
            {
              command = "/run/current-system/sw/bin/nixos-rebuild";
              options = ["NOPASSWD"];
            }
            {
              command = "/run/current-system/sw/bin/nix-store";
              options = ["NOPASSWD"];
            }
          ];
        }
      ];
    };
  };
}
