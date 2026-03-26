{ config, lib, pkgs, ... }:
{
  programs.npm.enable = true;

  environment.systemPackages = with pkgs; [
    cmake
    conda
    crane
    gcc
    gcc-unwrapped
    git
    gperftools
    icu
    lld
    llvmPackages.bintools
    nodejs
    opencv
    openssl
    pkg-config
    protobuf
    pyenv
    python3
    python312Packages.numpy
    python312Packages.opencv-python
    sqlite
    uv
  ];

  home-manager.users.zozano = {
    home.packages = with pkgs; [
      python3
      pipx
    ];
  };
}
