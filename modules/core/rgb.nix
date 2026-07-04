{ config, lib, pkgs, ... }:
let
  configDir = "/var/lib/openrgb";

  # Full detector map: everything false except ENE SMBus DRAM.
  # Generated from `openrgb --list-devices` detector schema on this machine.
  rgbSettings = pkgs.writeText "OpenRGB.json" (builtins.toJSON {
    Detectors.detectors = {
      "ENE SMBus DRAM" = true;
      # everything else disabled — the offenders that hung:
      "ASRock Motherboard SMBus Controllers" = false;
      "Corsair DRAM" = false;
      "Corsair Vengeance RGB DRAM" = false;
      "ASUS Aura SMBus Motherboard" = false;
      "Gigabyte RGB Fusion 2 DRAM" = false;
      "Gigabyte RGB Fusion 2 SMBus" = false;
      "HyperX DRAM" = false;
      # NVIDIA/AMD GPU I2C detectors also probe /dev/i2c-0..5 — disable if present
    };
  });

  no-rgb = pkgs.writeShellScriptBin "no-rgb" ''
    mkdir -p ${configDir}
    cp -f ${rgbSettings} ${configDir}/OpenRGB.json
    ${pkgs.openrgb}/bin/openrgb --config ${configDir} --noautoconnect --mode static --color 000000
  '';
in {
  systemd.services.no-rgb = {
    description = "no-rgb";
    serviceConfig = {
      ExecStart = "${no-rgb}/bin/no-rgb";
      Type = "oneshot";
      RemainAfterExit = true;
      TimeoutStartSec = "30s";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
