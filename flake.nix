{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    comfyui-nix.url = "github:utensils/comfyui-nix";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:nix-community/stylix";
    #stylix.inputs.home-manager.follows = "home-manager";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nix-flatpak,
    nixvim,
    comfyui-nix,
    stylix,
    sops-nix,
    ...
  }: {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      # Build name only - runtime hostname derived dynamically in ./modules/networking/hostname.nix
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
        nix-flatpak.nixosModules.nix-flatpak
        nixvim.nixosModules.nixvim
        stylix.nixosModules.stylix
        {
          disabledModules = [ "services/misc/comfyui.nix" ];
          imports = [comfyui-nix.nixosModules.default];
          nixpkgs.overlays = [comfyui-nix.overlays.default];

          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.zozano = import ./home.nix;
          home-manager.extraSpecialArgs = {inherit inputs;};
        }
      ];
    };
  };
}
