{
  description = "Custom comfyui package";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    comfyui-upstream.url = "github:dyscorv/nix-comfyui";
    comfyui-upstream.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, comfyui-upstream, ... }: let
    forAllSystems = f: nixpkgs.lib.genAttrs [ "x86_64-linux" ] (system:
      f {
        inherit system;
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [ comfyui-upstream.overlays.default ];
        };
      }
    );
  in {
    packages = forAllSystems ({ pkgs, ... }: {
      default = pkgs.comfyuiPackages.comfyui.override {
        extensions = [
          pkgs.comfyuiPackages.extensions.acly-inpaint
          pkgs.comfyuiPackages.extensions.acly-tooling
          pkgs.comfyuiPackages.extensions.cubiq-ipadapter-plus
          pkgs.comfyuiPackages.extensions.fannovel16-controlnet-aux
        ];
        commandLineArgs = [
          "--preview-method" "auto"
          "--normalvram"
          "--reserve-vram" "1.5"
          "--fp16-vae"
          "--fp16-unet"
          "--fp16-text-enc"
          "--cuda-device" "0"
          "--use-pytorch-cross-attention"
        ];
      };
    });
  };
}

