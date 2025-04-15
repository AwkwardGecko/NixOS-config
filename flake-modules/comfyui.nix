{ pkgs, inputs, lib, ... }:

let
  myRuntimeDir = "/home/zozano/comfyui";

  my-comfyui = inputs.nix-comfyui.packages.${pkgs.system}.comfyui.override {
    extensions = [
      pkgs.comfyuiPackages.extensions.acly-inpaint
      pkgs.comfyuiPackages.extensions.acly-tooling
      pkgs.comfyuiPackages.extensions.cubiq-ipadapter-plus
      pkgs.comfyuiPackages.extensions.fannovel16-controlnet-aux
    ];
    commandLineArgs = [
      "--preview-method"
      "auto"
    ];
  };

  comfyWrapper = pkgs.writeShellScriptBin "comfyui" ''
    mkdir -p "${myRuntimeDir}"
    cd "${myRuntimeDir}"
    exec ${my-comfyui}/bin/comfyui "$@"
  '';
in
{
  config = {
    environment.systemPackages = with pkgs; [
      my-comfyui
      comfyWrapper
      comfyuiPackages.krita-with-extensions
    ];
  };
}

