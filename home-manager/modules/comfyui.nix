#~/.dotfiles/home-manager/modules/comfyui.nix
{ config, lib, pkgs, ... }:

let
  comfyScript = ''
    #!/usr/bin/env bash
    sudo nvidia-smi -i 0 -c EXCLUSIVE_PROCESS
    export NIXPKGS_ALLOW_UNFREE=1
    export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:64
    cd ~/test-shell/ComfyUI
    git pull origin master
    cd ~/test-shell && NIXPKGS_ALLOW_UNFREE=1 nix-shell --run \
    /home/zozano/test-shell/.venv/bin/python -m pip install --upgrade pip \
    /home/zozano/test-shell/.venv/bin/python -m pip install -r /home/zozano/test-shell/ComfyUI/requirements.txt \
    python main.py \
      --lowvram \
      --force-fp16 \
      --use-split-cross-attention \
      --preview-method auto \
      --reserve-vram 0.5 \
      --disable-smart-memory
  '';
in
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
