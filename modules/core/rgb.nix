{
  config,
  lib,
  pkgs,
  ...
}: let
  # Only probe the ENE DRAM detector; skip all the buses that hang (ASRock, Corsair, GPU I2C, etc.)
  rgbSettings = pkgs.writeText "OpenRGB.json" (builtins.toJSON {
    Detectors = {
      detectors = {
        "ENE SMBus DRAM" = true;
      };
    };
  });

  no-rgb = pkgs.writeShellScriptBin "no-rgb" ''
    CFG="$HOME/.config/OpenRGB"
    mkdir -p "$CFG"
    cp -f ${rgbSettings} "$CFG/OpenRGB.json"
    N=$(${pkgs.openrgb}/bin/openrgb --noautoconnect --list-devices | grep -cE '^[0-9]+: ')
    for i in $(seq 0 $((N - 1))); do
      ${pkgs.openrgb}/bin/openrgb --noautoconnect --device $i --mode static --color 000000
    done
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
    wantedBy = ["multi-user.target"];
  };
}
