{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.custom-ssh-agent;
in {
  options.services.custom-ssh-agent = {
    enable = mkEnableOption "Custom SSH agent service";
  };

  config = mkIf cfg.enable {
    systemd.user.services.custom-ssh-agent = {
      description = "SSH key agent";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        Type = "simple";
        Environment = [
          "SSH_AUTH_SOCK=%t/ssh-agent.socket"
          "HYPRLAND_INSTANCE_SIGNATURE=%HYPRLAND_INSTANCE_SIGNATURE%"
        ];
        ExecStart = "${pkgs.openssh}/bin/ssh-agent -D -a $SSH_AUTH_SOCK";
      };
    };
  };
}

