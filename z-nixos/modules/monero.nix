{ lib, pkgs, config, ... }:

{
  # # Enable Monero service (for node management)
  # services.monero = {
  #   enable = true;
  #   dataDir = "/steam/Monero";
  #   
  #
  #
  #   #mining.enable = true;
  #   #mining.address = "48rmufMfAAiHH4N8q7wzdrdvcN7AXcgwTN2oEqCrCnBafCeyFaZNjZbG6ytK4BsnpUZnLuRMAstaeSpDs3JKg4qrT3x1K2K";  # Replace with your Monero wallet address
  #   #mining.threads = 6;  # Adjust based on how many threads you want to allocate for mining
  # };

  environment.systemPackages = with pkgs; [
    monero-gui
    monero-cli
  ];

  networking.firewall.allowedTCPPorts = [
    18080
    18081
  ];


    # users.users.zozano = {
    #   isSystemUser = true;
    #   group = "users";
    #   description = "Monero daemon user";
    #   home = "/var/lib/monero";
    #   createHome = true;
    # };



systemd.services.monero = {
  description = "monero daemon";
  after = [ "network.target" ];
  wantedBy = [ "multi-user.target" ];

  serviceConfig = {
    User = "zozano";
    Group = "users";
    ExecStart = "${pkgs.monero-cli}/bin/monerod --config-file=/steam/Monero/monero.conf --non-interactive --data-dir=/steam/Monero --out-peers 64 --prune-blockchain --enable-dns-blocklist --max-concurrency 8 --block-sync-size 20 --db-sync-mode fast:async:1000";
    ExecStop = "${pkgs.monero-cli}/bin/monerod exit";
    TimeoutStopSec = "90s";
    Restart = "always";
    SuccessExitStatus = [
      0
      1
    ];
  };
};

}
