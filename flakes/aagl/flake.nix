{
  description = "Star Rail launcher module using AAGL";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    aagl = {
         url = "github:ezKEa/aagl-gtk-on-nix";
         inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, aagl, ... }: {
    defaultModule = {
      imports = [ aagl.nixosModules.default ];

      nix.settings = aagl.nixConfig;

      programs.honkers-railway-launcher.enable = true;
      aagl.enableNixpkgsReleaseBranchCheck = false;
    };
  };
}

