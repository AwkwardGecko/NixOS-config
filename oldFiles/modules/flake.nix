{
	# to create the flake.lock file with user permissions, run:
	# $ nix flake lock
	
	description = "Flake File";

	inputs = {

		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		
		home-manager = {
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		aagl = {
			url = "github:ezKEa/aagl-gtk-on-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		
		hyprland.url = "github:hyprwm/Hyprland";
		hyprland-plugins = {
			url = "github:hyprwm/hyprland-plugins";
			inputs.hyprland.follows = "hyprland";
		};
	};

	outputs = { self, nixpkgs, home-manager, ... }:

		let
			lib = nixpkgs.lib;
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
		in {

		nixosConfigurations.z-nixos = lib.nixosSystem {

			inherit system;
			modules = [
				./configuration.nix {
					
					#imports = [ 
					#	aagl.nixosModules.default
					#];
					
					#nix.settings = aagl.nixConfig;
					#programs.honkers-railway-launcher.enable = true;
				}
			];
		};

		homeConfigurations = {
			
			z = home-manager.lib.homeManagerConfiguration {
				
				inherit pkgs;
				modules = [
					./home.nix
				];
			};
		};
	};
}

