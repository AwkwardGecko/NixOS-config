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




}
