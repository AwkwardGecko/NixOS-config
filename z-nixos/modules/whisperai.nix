{ pkgs, lib, config, ... }:

{
  environment.systemPackages = with pkgs; [
    python312Packages.openai-whisper
  ];
}
