#!/bin/bash

cd ~/test-shell
NIXPKGS_ALLOW_UNFREE=1 nix-shell
cd ComfyUI
python main.py
