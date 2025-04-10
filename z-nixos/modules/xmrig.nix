{ config, pkgs, ... }:

let
  xmrigConfigJSON = builtins.toJSON {
    pools = [
      {
        url = "pool.supportxmr.com:443";
        user = "48rmufMfAAiHH4N8q7wzdrdvcN7AXcgwTN2oEqCrCnBafCeyFaZNjZbG6ytK4BsnpUZnLuRMAstaeSpDs3JKg4qrT3x1K2K";
        pass = "x"; # optional password
        tls = true;
        keepalive = true;
      }
    ];
    cpu = { enabled = true; };
    opencl = { enabled = false; };
    cuda = { enabled = false; };
    donate-level = 1;
  };
in
{
  config = {
    environment.systemPackages = [ pkgs.xmrig ];

    # Write the XMRig config to /etc
    environment.etc."xmrig/config.json".text = xmrigConfigJSON;

    # Enable huge pages (recommended for RandomX)
    boot.kernel.sysctl."vm.nr_hugepages" = 128;

    systemd.services.xmrig = {
      description = "XMRig Miner";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.xmrig}/bin/xmrig --config=/etc/xmrig/config.json";
        Restart = "always";
        Nice = 10;
        NoNewPrivileges = true;
      };
    };
  };
}

