{ config, lib, pkgs, ... }:
{
  services.comfyui = {
    enable = true;
    cuda = true;
    enableManager = true;
    port = 8188;
    listenAddress = "127.0.0.1";
    dataDir = "/var/lib/comfyui";
    openFirewall = false;
    extraArgs = [
      "--lowvram"
      "--dont-upcast-attention"
      "--force-fp16"
      "--use-split-cross-attention"
      "--preview-method=auto"
      "--reserve-vram=512"
      "--disable-smart-memory"
    ];
  };

  #programs.nix-ld.enable = true; # enable if custom nodes fail to find system libs

  environment.systemPackages = with pkgs; [
    python312Packages.openai-whisper
  ];
}
