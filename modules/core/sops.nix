{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  # open with "sops ~/.dotfiles/secrets/secrets.yaml";

  #sops.secrets."grafana/user" = { };
  #services.grafana.settings.security.admin_user = config.sops.secrets."grafana/user".path;

  #sops.secrets."grafana/pass" = { };
  #services.grafana.settings.security.admin_password = config.sops.secrets."grafana/pass".path;

  # services.tailscale.authKeyFile = config.sops.secrets."tailscale/pre_auth_key".path;
  # sops.secrets."tailscale/pre_auth_key" = { };

  # users.users.z-home.openssh.authorizedKeys.keys = [
  #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKNdkhVz7z1xp1vK0GbjI6jfkbdkjckrlTRltJK6bp2q nixos-readonly"
  # ]; # allows ssh to G531GT-AL017T
}
