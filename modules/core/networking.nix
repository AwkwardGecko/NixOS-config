{ config, lib, pkgs, ... }:
{
  networking = {
    # dynamic hostname derived from hardware serial, located in ./modules/networking/hostname.nix
    networkmanager.enable = true;

    interfaces.enp10s0.macAddress = "04:42:1A:A7:FD:1F";
    nameservers = [
      "1.1.1.1"
      "9.9.9.9"
    ];
  };

  environment.systemPackages = with pkgs; [
    curl
    dig
    iproute2
    iperf3
    nettools
    pcapfix
    wget
  ];
}
