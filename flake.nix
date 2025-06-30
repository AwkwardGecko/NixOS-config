{
  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    star-rail.url = "github:ezKEa/aagl-gtk-on-nix";
    star-rail.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # flake-parts.url = "github:hercules-ci/flake-parts";
    # flake-parts.inputs.nixpkgs.follows = "nixpkgs";

    # nur.url = "github:nix-community/NUR";
    # nur.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixvim, star-rail, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [ inputs.nix-comfyui.overlays.default ];
    };
  in {
    nixosConfigurations = {
      z-nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./z-nixos/configuration.nix
          home-manager.nixosModules.home-manager
          nixvim.nixosModules.nixvim
          {
            environment.sessionVariables = {
              XDG_CURRENT_DESKTOP = "Hyprland";
              XDG_SESSION_TYPE = "wayland";
              XAUTHORITY = "\$HOME/.Xauthority";
            };

            imports = [ star-rail.nixosModules.default ];
            nix.settings = star-rail.nixConfig;
            programs.honkers-railway-launcher.enable = true;
            programs.honkers-launcher.enable = true;
            aagl.enableNixpkgsReleaseBranchCheck = false;

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.zozano = import ./home-manager/home.nix;
          }
        ];
      };
    };
  };
}
