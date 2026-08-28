{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    comfyui
  ];

  imports = [
    ./comfyui/mods.nix
  ];

  nixpkgs.config.cudaSupport = true;
}
