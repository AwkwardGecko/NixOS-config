#~/.dotfiles/home-manager/modules/comfyui.nix
{ config, lib, pkgs, ... }:

let
  comfyScript = ''
    #!/usr/bin/env bash
    set -euo pipefail

    # GPU mode
    sudo nvidia-smi -i 0 -c EXCLUSIVE_PROCESS
   
    export __GL_FRAMEBUFFER_SRGB_CAPABLE=1
    export NIXPKGS_ALLOW_UNFREE=1
    export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:64
    export COMFYUI_PORT=8188

    cd ~/test-shell/ComfyUI
    git pull origin master

    nix-shell ../shell.nix --run '
      source ../.venv/bin/activate
      pip check
      python main.py \
        --lowvram \
        --dont-upcast-attention \
        --force-fp16 \
        --use-split-cross-attention \
        --preview-method auto \
        --reserve-vram 0.5 \
        --disable-smart-memory
    '
  '';
in

  #   cd ~/test-shell && NIXPKGS_ALLOW_UNFREE=1 nix-shell --run '
  #     /home/zozano/test-shell/.venv/bin/python -m pip install --upgrade pip &&
  #     /home/zozano/test-shell/.venv/bin/python -m pip install -r /home/zozano/test-shell/ComfyUI/requirements.txt &&
  #     python /home/zozano/test-shell/ComfyUI/main.py \
  #       --lowvram \
  #       --dont-upcast-attention \
  #       --force-fp16 \
  #       --use-split-cross-attention \
  #       --preview-method auto \
  #       --reserve-vram 0.5 \
  #       --disable-smart-memory
  #   '
  # '';


{
  xdg.desktopEntries.comfyui = {
    name = "ComfyUI";
    exec = "kitty bash -c run-comfy.sh";
    # exec = "kitty bash -c \"cd /home/zozano/test-shell && NIXPKGS_ALLOW_UNFREE=1 nix-shell --run 'cd ComfyUI && python main.py --lowvram'\"";
    icon = "/home/zozano/.local/share/icons/comfyui.png";
    terminal = true;
    type = "Application";
    categories = [ "Graphics" ];
  };

  home.file.".local/bin/run-comfy.sh" = {
    executable = true;
    text = comfyScript;
  };
}
