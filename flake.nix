{
  # to create the flake.lock file with user permissions, run:
  # $ nix flake lock

  description = "Flake File";

  inputs = {

	nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

	nix-colors.url = "github:misterio77/nix-colors";

	home-manager = {
		url = "github:nix-community/home-manager/master";
		inputs.nixpkgs.follows = "nixpkgs";
	};

	aagl = {
		url = "github:ezKEa/aagl-gtk-on-nix";
		inputs.nixpkgs.follows = "nixpkgs";
	};


    plugin-onedark.url = "github:navarasu/onedark.nvim";
    plugin-onedark.flake = false;


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
      pkgs = import nixpkgs {
	  	#nixpkgs.legacyPackages.${system}
			inherit system;
		};
		# system = "x86_64-linux";
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
