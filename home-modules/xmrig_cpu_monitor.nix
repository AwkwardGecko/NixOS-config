{ config, pkgs, ... }:
{
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = "systemctl --user start xmrig";
        resumeCommand = "systemctl --user stop xmrig";
      }
    ];
  };

  systemd.user.services.xmrig = {
    Unit = {
      Description = "xmrig miner (user service)";
      After = [ "network.target" ];
    };
    Install.WantedBy = [ "default.target" ];
    Service = {
      ExecStart = "${pkgs.xmrig}/bin/xmrig";
      Restart = "always";
      Nice = 19;
      CPUWeight = 1;
    };
  };
}

