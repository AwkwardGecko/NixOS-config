{ config, lib, inputs, pkgs, ... }:
{
  services.comfyui = {
    enable = true;
    package = inputs.comfyui-nix.packages.x86_64-linux.cuda;
    enableManager = true;
    port = 8188;
    listenAddress = "127.0.0.1";
    
    user = "zozano";
    group = "users";
    dataDir = "/home/zozano/test-shell/ComfyUI";
    #dataDir = "var/lib/comfyui";
    openFirewall = false;
    extraArgs = [
      "--lowvram"
      "--dont-upcast-attention"
      "--force-fp16"
      "--use-split-cross-attention"
      "--preview-method=auto"
      "--reserve-vram=512"
      "--enable-manager"
    ];
  };

  #programs.nix-ld.enable = true; # enable if custom nodes fail to find system libs

  environment.systemPackages = with pkgs; [
    python312Packages.openai-whisper
  ];

    # "/steam" = {
    #   device = "/dev/disk/by-uuid/249c8bec-3ec2-4b89-8618-748cd918d4ba";
    #   fsType = "btrfs";
    #   options = [
    #     "space_cache=v2"
    #     "discard=async"
    #   ];
    # };
}
