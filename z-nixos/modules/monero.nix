{ lib, pkgs, ... }:

{
  # Enable Monero service (for node management)
  services.monero = {
    enable = true;
    mining.enable = true;
    #mining.wallet = "your-wallet-address";  # Replace with your Monero wallet address
    mining.threads = 6;  # Adjust based on how many threads you want to allocate for mining
  };

  # Install XMRig and configure it
  environment.systemPackages = with pkgs; [
    xmrig  # Install XMRig mining software
  ];

  # XMRig configuration: create the config file with pool and wallet settings
  systemd.services.xmrig = {
    description = "XMRig Monero miner";
    after = [ "network.target" ];

    # Specify the custom XMRig configuration
    execStart = "${pkgs.xmrig}/bin/xmrig --config /etc/xmrig/config.json";  # Ensure XMRig uses the custom config file

    # Set limits for the mining process
    CPUQuota = "75%";  # Limit mining process to 75% CPU usage
    Nice = 10;  # Lower priority for mining to prevent system performance issues
    restart = "always";  # Automatically restart mining if it crashes
    workingDirectory = "/var/lib/xmrig";  # Directory to store logs and work files
  };

  # Create the XMRig configuration file with pool and wallet settings
  environment.etc."xmrig/config.json".text = ''
    {
      "url": "monero-eu1.nanopool.org:14444",  # Replace with your pool's address and port
      "user": "your-wallet-address",  # Replace with your Monero wallet address
      "pass": "x",  # Pool password (usually "x")
      "cpu": {
        "enabled": true,
        "threads": 6  # Number of CPU threads for mining
      },
      "gpu": {
        "enabled": true,
        "opencl": true,
        "cuda": true
      },
      "log_level": 3,
      "print_time": 60
    }
  '';

  # Optional: Power management to optimize energy usage during mining
  powerManagement.cpuFreqGovernor = "powersave";  # Use a low power governor when not actively using the CPU


}

