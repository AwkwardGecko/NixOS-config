{ lib, pkgs, config, ... }:

{
  # Enable Monero service (for node management)
  services.monero = {
    enable = true;
    dataDir = "/steam/Monero";
    


    #mining.enable = true;
    #mining.address = "48rmufMfAAiHH4N8q7wzdrdvcN7AXcgwTN2oEqCrCnBafCeyFaZNjZbG6ytK4BsnpUZnLuRMAstaeSpDs3JKg4qrT3x1K2K";  # Replace with your Monero wallet address
    #mining.threads = 6;  # Adjust based on how many threads you want to allocate for mining
  };

  environment.systemPackages = with pkgs; [
    monero-gui
    monero-cli
  ];


  systemd.services.monero-cli.serviceConfig.ExecStart = lib.mkForce ''
    ${pkgs.monero}/bin/monerod \
      --data-dir /steam/Monero \
      --prune-blockchain \
      --out-peers 64 \
      --enable-dns-blocklist \
      --max-concurrency 8 \
      --block-sync-size 20 \
      --db-sync-mode fast:async:1000
  '';


}
