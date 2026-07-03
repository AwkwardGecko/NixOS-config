{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  comfyuiDir = "${config.home.homeDirectory}/.local/share/ComfyUI";
in {
  # services.sillytavern = {
  #   enable = true;
  #   port = 8045;
  #   listen = true;
  # };

  services.comfyui = {
    enable = true;
    package = inputs.comfyui-nix.packages.x86_64-linux.cuda;
    enableManager = true;
    port = 8188;
    listenAddress = "127.0.0.1";

    user = "zozano";
    group = "users";
    dataDir = "/home/zozano/.local/share/ComfyUI";
    #dataDir = "var/lib/comfyui";
    openFirewall = false;
    extraArgs = [
      "--lowvram" # Aggressively offloads model components to system RAM when not in use, only loading pieces to VRAM as needed.
      # Essential for 8GB cards running SDXL-based models.

      "--dont-upcast-attention" # Prevents attention layers from being promoted to fp32 (which doubles their VRAM cost).
      # Keeps them in fp16 with negligible quality loss.

      "--force-fp16" #Forces all model weights and computation to half-precision. Roughly halves VRAM usage vs fp32.
      #Minor quality trade-off that's invisible in practice.

      "--use-split-cross-attention" # Splits cross-attention into smaller chunks instead of computing the full attention matrix
      # at once, reducing peak VRAM spikes.

      "--preview-method=auto"

      "--reserve-vram=512"
    ];
  };

  #programs.nix-ld.enable = true; # enable if custom nodes fail to find system libs

  environment.systemPackages = with pkgs; [
    python313Packages.openai-whisper
    #python313Packages.google-genai
    whisperx
  ];

  # "/steam" = {
  #   device = "/dev/disk/by-uuid/249c8bec-3ec2-4b89-8618-748cd918d4ba";
  #   fsType = "btrfs";
  #   options = [
  #     "space_cache=v2"
  #     "discard=async"
  #   ];
  # };

  home-manager.users.zozano = {
    ###########################################################################
    # 1. Nautilus / Tracker3 — stop indexing + search
    ###########################################################################
    dconf.settings."org/freedesktop/Tracker3/Miner/Files" = {
      # basename-matched, applies wherever a dir with this name shows up
      ignored-directories = ["po" "CVS" "core-dumps" "lost+found" "ComfyUI"];
      # marker-file based, path-precise (belt and suspenders)
      ignored-directories-with-content = [".trackerignore" ".git" ".hg" ".nomedia"];
    };

    ###########################################################################
    # 2. Dolphin / Baloo — stop indexing + search
    ###########################################################################
    xdg.configFile."baloofilerc".text = ''
      [General]
      exclude folders[$e]=${comfyuiDir}/
    '';

    ###########################################################################
    # 3. Drop marker files in the dir itself — makes exclusion spec-guaranteed
    #    even if dconf/baloofilerc get reset or you use a different machine
    ###########################################################################
    # home.activation.excludeComfyUIFromIndexers = lib.hm.dag.entryAfter ["writeBoundary"] ''
    #  $DRY_RUN_CMD mkdir -p "${comfyuiDir}"
    #  $DRY_RUN_CMD touch "${comfyuiDir}/.trackerignore" "${comfyuiDir}/.nomedia"
    #'';

    ###########################################################################
    # 4. Relocate the thumbnail cache into the ComfyUI root
    ###########################################################################
    #   home.file.".cache/thumbnails".source =
    #     config.lib.file.mkOutOfStoreSymlink "${comfyuiDir}/.thumbnails";
  };
}
