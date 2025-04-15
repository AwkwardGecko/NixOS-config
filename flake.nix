{
  description = "Flake File";

  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-comfyui = {
      url = "github:dyscorv/nix-comfyui";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    self,
    nixpkgs,
    home-manager,
    aagl,
    nixvim,
    nix-comfyui,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      z-nixos = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./z-nixos/configuration.nix
          home-manager.nixosModules.home-manager
          nixvim.nixosModules.nixvim
          {
            imports = [ 
              aagl.nixosModules.default
              nix-comfyui.nixosModules.default
            ];
            
            nix.settings = aagl.nixConfig;
            programs.honkers-railway-launcher.enable = true;

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.zozano = import ./home-manager/home.nix;
          }
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };

    # Expose comfyui as a runnable app with `nix run`
    apps.${system}.default = nix-comfyui.apps.${system}.default;

    # If you want to pull in packages (e.g. to include in your system)
    packages.${system}.comfyui = nix-comfyui.packages.${system}.default;
  };
}

