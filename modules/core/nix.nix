{
  config,
  lib,
  pkgs,
  ...
}: {
  nix = {
    gc = {
      # garbage collection
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };

    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05";

  environment.systemPackages = with pkgs; [
    alejandra
    compose2nix
    nixd
    nix-prefetch-github
    statix
  ];
}
