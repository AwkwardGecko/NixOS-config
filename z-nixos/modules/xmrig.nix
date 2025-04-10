{ config, pkgs, lib, ... }:

let
  xmrigConfigJSON = builtins.toJSON {
    api = {
      id = null;
      worker-id = "5600G-rig";
    };
    autosave = true;
    background = false;
    colors = true;
    randomx = {
      "1gb-pages" = false;
      rdmsr = true;
      wrmsr = true;
      numa = true;
      scratchpad_prefetch_mode = 1;
      huge-pages = true;
      huge-pages-jit = true;
    };
    cpu = {
      enabled = true;
      huge-pages = true;
      hw-aes = null;
      priority = null;
      memory-pool = true;
      yield = true;
      max-threads-hint = 100;
      asm = true;
      argon2-impl = null;
      cn = [];
      rx = [];
      astrobwt = [];
    };
    opencl = {
      enabled = false;
    };
    cuda = {
      enabled = false;
    };
    donate-level = 1;
    log-file = null;
    pools = [
      {
        url = "pool.supportxmr.com:443";
        user = "YOUR_MONERO_WALLET_ADDRESS";
        pass = "5600G";
        rig-id = null;
        nicehash = false;
        enabled = true;
        tls = true;
        tls-fingerprint = null;
        daemon = false;
        socks5 = null;
        keepalive = true;
        coin = null;
      }
    ];
    print-time = 60;
    health-print-time = 60;
    retries = 5;
    retry-pause = 5;
    syslog = false;
    user-agent = null;
    verbose = 0;
  };
in
{
  config = {
    # Install XMRig package
    environment.systemPackages = with pkgs; [
      xmrig
    ];

    # Enable huge pages for better RandomX performance
    boot.kernel.sysctl."vm.nr_hugepages" = 128;

    # Systemd service to run xmrig on boot
    systemd.services.xmrig = {
      description = "XMRig CPU Miner";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.xmrig}/bin/xmrig --config=/etc/xmrig/config.json";
        Restart = "always";
        Nice = 10;
        NoNewPrivileges = true;
        PrivateTmp = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        MemoryDenyWriteExecute = false;
      };
    };

    # Write config to /etc/xmrig/config.json
    environment.etc."xmrig/config.json".text = xmrigConfigJSON;
  };
}

