{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    signal-desktop
    signal-export
  ];

  imports = [
    ./signal-read-notify.nix
  ];

  services.signal-read-notify.enable = true;

  home-manager.users.zozano.systemd.user.services.signal-desktop = {
    Unit = {
      Description = "Signal Autostart";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.signal-desktop}/bin/signal-desktop";
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  };
}
