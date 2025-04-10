{ config, pkgs, ... }:

let
  # Path to the script
  cpuMonitorScript = "/home/zozano/.dotfiles/scripts/xmrig_cpu_monitor.sh";
in {

  # Define the CPU monitor service
  systemd.services.cpu-monitor = {
    description = "Monitor CPU usage and control xmrig";
    serviceConfig.ExecStart = cpuMonitorScript;
    serviceConfig.Type = "simple";
    serviceConfig.Restart = "always";  # Optionally restart the service if it fails
  };

  # Define the timer that runs the script periodically
  systemd.timers.cpu-monitor = {
    description = "Run CPU monitor script every minute";
    timerConfig.OnBootSec = "5min";  # Delay after boot before first run
    timerConfig.OnUnitActiveSec = "1min";  # Periodic execution every minute
    timerConfig.WakeSystem = true;  # Ensure the system wakes up if asleep
  };

}

