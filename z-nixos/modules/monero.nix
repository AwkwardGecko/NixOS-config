{ lib, pkgs, config, ... }:

{
  # Enable Monero service (for node management)
  services.monero = {
    enable = true;
    dataDir = "/steam/Monero";
    
  systemd.services.monero.serviceConfig.ExecStart = lib.mkForce ''
    ${pkgs.monero}/bin/monerod \
      --data-dir /steam/Monero \
      --out-peers 64 \
      --prune-blockchain \
      --enable-dns-blocklist \
      --max-concurrency 8 \
      --block-sync-size 20 \
      --db-sync-mode fast:async:1000
  '';

    #mining.enable = true;
    #mining.address = "48rmufMfAAiHH4N8q7wzdrdvcN7AXcgwTN2oEqCrCnBafCeyFaZNjZbG6ytK4BsnpUZnLuRMAstaeSpDs3JKg4qrT3x1K2K";  # Replace with your Monero wallet address
    #mining.threads = 6;  # Adjust based on how many threads you want to allocate for mining
  };

}
