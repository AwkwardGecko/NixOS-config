{pkgs, ...}: {
  systemd.user.services.gmod-idle = {
    description = "Launch Garry's Mod for Addict achievement";

    after = ["graphical-session.target"];
    partOf = ["graphical-session.target"];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.steam}/bin/steam -silent -applaunch 4000";
    };
  };

  systemd.user.timers.gmod-idle = {
    description = "Launch Garry's Mod five minutes after boot";
    wantedBy = ["graphical-session.target"];

    timerConfig = {
      OnBootSec = "5min";
      AccuracySec = "1s";
      Unit = "gmod-idle.service";
    };
  };
}
