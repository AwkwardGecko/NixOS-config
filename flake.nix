{
  # to create the flake.lock file with user permissions, run:
  # $ nix flake lock

  description = "Flake File";

  inputs = {

	stable-diffusion-webui-nix = {
		url = "github:Janrupf/stable-diffusion-webui-nix/main";
		inputs.nixpkgs.follows = "nixpkgs";
	};
	
	nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

	nix-colors.url = "github:misterio77/nix-colors";

	nvchad4nix = {
		url = "github:nix-community/nix4nvchad";
		inputs.nixpkgs.follows = "nixpkgs";
	};

	home-manager = {
		url = "github:nix-community/home-manager/master";
		inputs.nixpkgs.follows = "nixpkgs";
	};

	aagl = {
		url = "github:ezKEa/aagl-gtk-on-nix";
		inputs.nixpkgs.follows = "nixpkgs";
	};

  };

	outputs =
    {
      self,
      nixpkgs,
      home-manager,
      aagl,
      ...
    }@inputs:

    let
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        z-nixos = lib.nixosSystem {
          inherit system;
          modules = [
            ./sys/configuration.nix
            {

              imports = [
                aagl.nixosModules.default
              ];

              nix.settings = aagl.nixConfig;
              programs.honkers-railway-launcher.enable = true;
            }
          ];
        };
      };

      homeConfigurations = {
        zozano = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [ ./home-manager/home.nix ];
        };
      };
    };
}
