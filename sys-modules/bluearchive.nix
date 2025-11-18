{ config, pkgs, lib, ... }:

{
  virtualisation.waydroid.enable = true;
  

  boot.kernelModules = [
    "binder_linux"
    "ashmem_linux"
  ];

  boot.extraModprobeConfig = ''
    options binder_linux devices=binder,hwbinder,vndbinder
  '';}
