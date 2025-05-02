#!/bin/bash

cd ~/test-shell
NIXPKGS_ALLOW_UNFREE=1 nix-shell --run "cd ComfyUI && python main.py"
