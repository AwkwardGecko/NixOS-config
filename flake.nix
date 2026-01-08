{
  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    #comfyui.url = "github:utensils/nix-comfyui";
    #comfyui.inputs.nixpkgs.follows = "nixpkgs";

    #aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    #aagl.inputs.nixpkgs.follows = "nixpkgs"; # Name of nixpkgs input you want to use

  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixvim,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        z-nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            nixvim.nixosModules.nixvim
            #comfyui.nixosModules.default
            {
              #imports = [ aagl.nixosModules.default ];
              #nix.settings = aagl.nixConfig;
              # programs.honkers-railway-launcher.enable = true;

              environment = {
                sessionVariables = {
                  XDG_CURRENT_DESKTOP = "Hyprland";
                  XDG_SESSION_TYPE = "wayland";
                  XAUTHORITY = "\$HOME/.Xauthority";
                };
              };

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.zozano = import ./home.nix;
            }
          ];
        };
      };
    };
}
