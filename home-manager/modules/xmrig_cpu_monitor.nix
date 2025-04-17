{ config, pkgs, ... }:
{
  systemd.user.services."xmrig-idle" = {
  description = "Manage xmrig based on idle state (Wayland)";
  wantedBy = [ "graphical-session.target" ];
  script = ''
    exec swayidle \
      timeout 300 'systemctl --user start xmrig' \
      resume 'systemctl --user stop xmrig'
  '';
  serviceConfig = {
    Restart = "always";
  };

  environment.systemPackages = with pkgs; [
    swayidle
  ];
};
