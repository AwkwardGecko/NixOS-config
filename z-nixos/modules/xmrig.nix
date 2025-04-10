{ config, pkgs, lib, ... }:

let
  xmrigWithTLS = pkgs.xmrig.override {
    withOpenSSL = true;
  };

  xmrigConfigJSON = builtins.toJSON {
    api = {
      id = null;
      "worker-id" = "5600G-rig";
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
      "memory-pool" = true;
      yield = true;
      "max-threads-hint" = 100;
      asm = true;
      "argon2-impl" = null;
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
    "donate-level" = 1;
    "log-file" = null;
    pools = [
      {
        url = "monero-asia1.nanopool.org:14444";
        user = "48rmufMfAAiHH4N8q7wzdrdvcN7AXcgwTN2oEqCrCnBafCeyFaZNjZbG6ytK4BsnpUZnLuRMAstaeSpDs3JKg4qrT3x1K2K";
        pass = "5600G";
        "rig-id" = null;
        nicehash = false;
        enabled = true;
        tls = true;
        "tls-fingerprint" = null;
        daemon = false;
        socks5 = null;
        keepalive = true;
        coin = null;
      }
    ];
    "print-time" = 60;
    "health-print-time" = 60;
    retries = 5;
    "retry-pause" = 5;
    syslog = false;
    "user-agent" = null;
    verbose = 0;
  };
in
{
  config = {
    environment.systemPackages = [ xmrigWithTLS ];

    # Enable huge pages
    boot.kernel.sysctl."vm.nr_hugepages" = 128;

    # Write config file to /etc
    environment.etc."xmrig/config.json".text = xmrigConfigJSON;

    # Systemd service for xmrig
    systemd.services.xmrig = {
      description = "XMRig CPU Miner";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${xmrigWithTLS}/bin/xmrig --config=/etc/xmrig/config.json";
        Restart = "always";
        Nice = 10;
        NoNewPrivileges = true;
        PrivateTmp = true;
        # Relaxed so TLS works
        ProtectSystem = "full";
        ProtectHome = false;
        MemoryDenyWriteExecute = false;
      };
    };
  };
}

