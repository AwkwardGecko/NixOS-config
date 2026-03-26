{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
  ];
}
