{ config, pkgs, lib, ... }:

let
  xmrigConfig = builtins.toJSON {
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
      "huge-pages-jit" = true;
    };
    cpu = {
      enabled = true;
      "huge-pages" = true;
      "hw-aes" = null;
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
        url = "pool.supportxmr.com:443";
        user = "YOUR_MONERO_WALLET_ADDRESS";
        pass = "5600G";
        "nicehash" = false;
        tls = true;
        daemon = false;
        "keepalive" = true;
        enabled = true;
      }
    ];
    "print-time" = 60;
    "health-print-time" = 60;
    retries = 5;
    "retry-pause" = 5;
    syslog = false;
    verbose = 0;
  };
in
{
  imports = [];

  config = {
    environment.systemPackages = with pkgs; [
      xmrig
    ];

    # Enable hugepages
    boot.kernel.sysctl."vm.nr_hugepages" = 128;

    # Optional: Set nice value so mining doesn't lag the system
    systemd.services.xmrig = {
      description = "XMRig Miner for Monero";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.xmrig}/bin/xmrig --config=/

