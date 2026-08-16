#~/.dotfiles/z-nixos/modules/controller.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  #services.udev.packages = [ pkgs.game-devices-udev-rules ];

  hardware.enableRedistributableFirmware = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
        Privacy = "device";
        JustWorksRepairing = "always";
      };
      Policy = {
        AutoEnable = true;
      };
    };
    input.General = {
      ClassicBondedOnly = true;
      IdleTimeout = 0;
    };

  };


  hardware = {
    xone.enable = true; # dongle support
    xpadneo.enable = true; # bluetooth support
    steam-hardware.enable = true;
    uinput.enable = true;
  };

  services.upower.enable = true;

  environment.systemPackages = with pkgs; [
    bluetuith
    evtest
    linuxConsoleTools
  ];

  boot.blacklistedKernelModules = ["xone_dongle"]; # delayed load to prevent boot fault

  systemd.user.services.load-xone-dongle = {
    description = "Load Xbox dongle driver after login";
    wantedBy = ["graphical.target"];
    after = ["graphical.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 60";
      ExecStart = "${pkgs.kmod}/bin/modprobe xone_dongle";
    };
  };
}
