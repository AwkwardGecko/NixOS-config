{ lib, pkgs, ... }:

{
  # Enable Monero service (for node management)
  services.monero = {
    enable = true;
    dataDir = "/steam/Monero";
    #    mining.enable = true;
    #mining.wallet = "your-wallet-address";  # Replace with your Monero wallet address
    #mining.threads = 6;  # Adjust based on how many threads you want to allocate for mining
  };

  # Install XMRig and configure it
  environment.systemPackages = with pkgs; [
    xmrig  # Install XMRig mining software
    monerod # checking sync speed 
  ];



  # Optional: Power management to optimize energy usage during mining
  powerManagement.cpuFreqGovernor = "powersave";  # Use a low power governor when not actively using the CPU


}

