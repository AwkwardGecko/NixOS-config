{ config, pkgs, ... }:

{
  systemd.user.services.xmrig = {
    Unit = {
      Description = "xmrig miner (user service)";
      After = [ "default.target" ];
    };
    Service = {
      Environment = "XMRIG_CONFIG=%h/.config/xmrig/config.json";
      ExecStart = "${pkgs.xmrig}/bin/xmrig --config %h/.config/xmrig/config.json";
      Restart = "always";
      RestartSec = 5;
      Nice = 19;
      CPUWeight = 1;
    };
  };

  # xmrig settings as a user module
  xdg.configFile."xmrig/config.json".text = builtins.toJSON {
    autosave = true;
    "autosave-interval" = 300;
    cpu = true;
    opencl = false;
    cuda = false;
    "donate-level" = 0;
    "cpu-priority" = 5;
    "cpu-usage" = 20;
    threads = 2;
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
