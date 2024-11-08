{
	description = "Honkai: Star Rail";

	inputs = {

		aagl = {
			url = "github:ezKEa/aagl-gtk-on-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};       

	outputs = { self, nixpkgs, aagl, ... }@inputs: 
  
	let
		lib = nixpkgs.lib;
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in {

		nixosConfigurations = {

			nixos = lib.nixosSystem {
				
				inherit system;
				modules = {
					
					imports = [ aagl.nixosModules.default ];
					nix.settings = aagl.nixConfig; # Set up Cachix
					programs.honkers-railway-launcher.enable = true;
				};
			};
		};
	};
}
