
	#################
	### STAR RAIL ###
	#################

{
	inputs = {
		aagl.url = "github:ezKEa/aagl-gtk-on-nix";
		aagl.inputs.nixpkgs.follows = "nixpkgs"; # Name of nixpkgs input you want to use
	};

	outputs = { self, nixpkgs, aagl, ... }: {
	
		
		nixosConfigurations.z-nixos = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
			modules = [
				./configuration.nix {
					imports = [ aagl.nixosModules.default ];
        				nix.settings = aagl.nixConfig; # Set up Cachix
        				programs.honkers-railway-launcher.enable = true;
        			}
			];
		};
	};
}
