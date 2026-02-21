{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    python312
    python312Packages.diffusers
    python312Packages.pip
    python312Packages.safetensors
    python312Packages.setuptools
    python312Packages.virtualenv
    python312Packages.sqlalchemy
    python312Packages.aiohttp
    python312Packages.alembic
    #python312Packages.onnxruntime-gpu
    git
    cudatoolkit
    gcc
    libGL
    libglvnd
    mesa
    opencv
    stdenv.cc.cc.lib
    zlib
  ];
}
