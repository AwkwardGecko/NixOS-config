{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    monero-gui
    monero-cli
    xmrig
    bisq2
  ];

  services.monero = {
    enable = true;
    prune = true;
    dataDir = "/monero";

    extraConfig = ''
      enable-dns-blocklist=1
    '';
   };

  networking.firewall.allowedTCPPorts = [
    18080
    #18081
  ];
}
