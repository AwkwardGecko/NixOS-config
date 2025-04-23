{ config, pkgs, lib, ... }:

let
  secrets = import ../../secrets/secrets.nix;
in
{
  # other config...

  environment.etc = lib.mkMerge [
    (lib.mapAttrs' (name: secret:
      lib.nameValuePair name {
        source = secret.path;
        mode = secret.mode or "0400";
        user = secret.owner or "root";
        group = secret.group or "root";
      }) secrets)
  ];
}

