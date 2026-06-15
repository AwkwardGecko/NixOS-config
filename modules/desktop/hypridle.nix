{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.zozano = {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          hide_cursor = true;
          ignore_empty_input = true;
        };
      };
    };

    services.hypridle = {
      enable = true;
      settings = {
        general = {
          #lock_cmd = "pidof hyprlock || hyprlock";
          #before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
        };

        listener = [
          #{
          #timeout = 300;
          #on-timeout = "hyprctl dispatch dpms off";
          #on-resume = "hyprctl dispatch dpms on && hyprctl reload";
          #on-resume = "hyprctl dispatch dpms on";
          #}

          {
            timeout = 600;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };

    wayland.windowManager.hyprland.settings.misc.allow_session_lock_restore = true;
  };

  security.pam.services.hyprlock = {};
  hardware.nvidia.powerManagement.enable = true;

  boot.resumeDevice = "/dev/disk/by-label/swap";
}
