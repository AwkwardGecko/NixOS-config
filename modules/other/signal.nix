{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.signal-read-notify;
  script = ./signal-read-notify.py;
in {
  options.services.signal-read-notify = {
    enable = lib.mkEnableOption "Signal read receipt desktop notifications";
    pollInterval = lib.mkOption {
      type = lib.types.int;
      default = 3;
      description = "Polling interval in seconds.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      signal-desktop
      signal-export
    ];

    systemd.user.services.signal-read-notify = {
      # ...
    };

    home.packages = with pkgs; [
      libnotify
      sqlcipher
    ];
  };
}
