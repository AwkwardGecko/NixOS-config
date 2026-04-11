{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.signal-read-notify;
  script = ./signal-read-notify.py;
in {
  environment.systemPackages = with pkgs; [
    signal-desktop
    signal-export
  ];

  options.services.signal-read-notify = {
    enable = lib.mkEnableOption "Signal read receipt desktop notifications";

    pollInterval = lib.mkOption {
      type = lib.types.int;
      default = 3;
      description = "Polling interval in seconds.";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.signal-read-notify = {
      Unit = {
        Description = "Signal read receipt notifier";
        After = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
      };

      Service = {
        ExecStart = "${pkgs.python3}/bin/python3 ${script}";
        Restart = "on-failure";
        RestartSec = 10;
        Environment = [
          "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/%U/bus"
          "DISPLAY=:0"
          "WAYLAND_DISPLAY=wayland-1"
        ];
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };

    home.packages = with pkgs; [
      libnotify
      sqlcipher
    ];
  };
}
