###############
### CRONTAB ###
###############

{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.cron = {
    enable = true;
    systemCronJobs = [
    "@reboot dex ~/.local/share/applications/teamviewer.desktop"
    ]
  };
}
