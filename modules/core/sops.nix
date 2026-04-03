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

  # services.nextcloud.config.adminpassFile = config.sops.secrets."nextcloud/adminpassFile".path;
  # sops.secrets."nextcloud/adminpassFile" = {
  #  owner = "nextcloud";
  #  group = "nextcloud";
  # };

  # services.headscale.settings.noise.private_key_path = config.sops.secrets."headscale/noise_key".path;
  # sops.secrets."headscale/noise_key" = {
  #   owner = "headscale";
  #   group = "headscale";
  #   mode = "0400";
  # };

  # services.tailscale.authKeyFile = config.sops.secrets."tailscale/auth_key".path;
  # sops.secrets."tailscale/auth_key" = { };

  # sops.secrets.musicbrainz-user = {
  #   owner = "z-home";
  #   group = "users";
  # };
  # sops.secrets.musicbrainz-pass = {
  #   owner = "z-home";
  #   group = "users";
  # };

  # users.users.z-home.openssh.authorizedKeys.keys = [
  #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKNdkhVz7z1xp1vK0GbjI6jfkbdkjckrlTRltJK6bp2q nixos-readonly"
  # ]; # allows ssh to G531GT-AL017T
}
