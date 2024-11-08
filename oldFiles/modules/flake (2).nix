{

	description = "Nixos config flake";

	inputs = {

		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		
		swww.url = "github:LGFae/swww";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		aagl = {		
			url = "github:ezKEa/aagl-gtk-on-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, aagl, ... }@inputs:

		let
			system = "x86_86-linux";
			pkgs = nixpkgs.legacyPackages.${system};
		in {

		nixosConfigurations.default = nixpkgs.lib.nixosSystem {

			system = "x86_86-linux";
			specialArgs = { inherit inputs; };
			modules = [ 

				./hosts/default/configuration.nix
				
				{
					imports = [ aagl.nixosModules.default ];
        				nix.settings = aagl.nixConfig;
        				programs.honkers-railway-launcher.enable = true;
				}  
			];
		};
	};
}

