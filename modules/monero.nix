{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    monero-gui
    monero-cli
  ]; 

  services.monero = {
    enable = true;
    prune = true;
    dataDir = "/monero";

    extraConfig = ''
      out-peers=64
      enable-dns-blocklist=1
      db-sync-mode-fast:async:1000
    '';
  
   };



  networking.firewall.allowedTCPPorts = [
    18080
    #18081
  ];

  # systemd.services.monero = {
  #   description = "monero daemon";
  #   after = [ "network.target" ];
  #   wantedBy = [ "multi-user.target" ];
  #
  #   serviceConfig = {
  #     User = "zozano";
  #     Group = "users";
  #     ExecStart = "${pkgs.monero-cli}/bin/monerod --config-file=/home/zozano/.bitmonero/monero.conf --non-interactive --data-dir=/home/zozano/.bitmonero --out-peers 64 --prune-blockchain --enable-dns-blocklist --max-concurrency 8 --block-sync-size 20 --db-sync-mode fast:async:1000";
  #     ExecStop = "${pkgs.monero-cli}/bin/monerod exit";
  #     TimeoutStopSec = "90s";
  #     Restart = "always";
  #     SuccessExitStatus = [
  #       0
  #       1
  #     ];
  #   };
  # };
}
