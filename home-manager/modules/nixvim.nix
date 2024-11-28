{
  config,
  pkgs,
  lib,
  ...
}:
{
  inputs.nixvim = {
        url = "github:nix-community/nixvim";
        # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
        inputs.nixpkgs.follows = "nixpkgs";
  };
}
