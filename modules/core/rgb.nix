#~/.dotfiles/modules/no-rgb.nix
{pkgs, ...}: {
  hardware.i2c.enable = true;
  boot.kernelModules = ["i2c-piix4"];

  systemd.services.no-rgb = {
    description = "no-rgb";
    wantedBy = ["multi-user.target"];
    after = ["systemd-modules-load.service"];
    path = [pkgs.openrgb];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      TimeoutStartSec = "60s";
      StateDirectory = "openrgb";
    };
    script = ''
      until ls /dev/i2c-* >/dev/null 2>&1; do sleep 1; done

      cp -f ${pkgs.writeText "OpenRGB.json" (builtins.toJSON {
        Detectors.detectors = {
          "ENE SMBus DRAM" = true;
          "ASRock Motherboard SMBus Controllers" = false;
          "Corsair DRAM" = false;
          "Corsair Vengeance RGB DRAM" = false;
          "ASUS Aura SMBus Motherboard" = false;
          "Gigabyte RGB Fusion 2 DRAM" = false;
          "Gigabyte RGB Fusion 2 SMBus" = false;
          "HyperX DRAM" = false;
        };
      })} /var/lib/openrgb/OpenRGB.json

      for _ in 1 2 3; do
        openrgb --config /var/lib/openrgb --noautoconnect --mode static --color 000000
        sleep 2
      done
    '';
  };
}
