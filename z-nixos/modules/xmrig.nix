{ pkgs, ... }:
{
  networking.firewall = {
    allowedUDPPorts = [ 9000 ];
    allowedTCPPorts = [ 9000 ];
  };

  boot.initrd.availableKernelModules = [ "msr" ];
  boot.kernelModules = [ "msr" ];


  systemd.services.xmrig = {
    description = "xmrig miner (system/root service)";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.xmrig}/bin/xmrig --config /etc/xmrig/config.json";
      Restart = "always";
      RestartSec = 5;
      Nice = 19;
      CPUWeight = 1;
      User = "root"; # Ensures root privileges
    };
  };

  # Deploy your config.json to /etc/xmrig/config.json
  environment.etc."xmrig/config.json".text = builtins.toJSON {
    autosave = true;
    "autosave-interval" = 300;
    cpu = true;
    opencl = false;
    cuda = false;
    "donate-level" = 0;
    "cpu-priority" = 5;
    "cpu-usage" = 95;
    threads = 12;
    randomx = {
      "large-pages" = true;
      mode = "auto";
      cache = 2;
    };
    pools = [
      {
        url = "pool.hashvault.pro:443";
        user = "48rmufMfAAiHH4N8q7wzdrdvcN7AXcgwTN2oEqCrCnBafCeyFaZNjZbG6ytK4BsnpUZnLuRMAstaeSpDs3JKg4qrT3x1K2K";
        pass = "somethingorothjer";
        keepalive = true;
        tls = true;
      }
    ];
  };
}

# Check ~/.dotfiles/home-manager/modules/xmrig.nix for more
