{
  config,
  lib,
  pkgs,
  ...
}: let
  no-rgb = pkgs.writeScriptBin "no-rgb" ''
    #!/bin/sh
    NUM_DEVICES=$(${pkgs.openrgb}/bin/openrgb --noautoconnect --list-devices | grep -E '^[0-9]+: ' | wc -l)

    for i in $(seq 0 $(($NUM_DEVICES - 1))); do
      ${pkgs.openrgb}/bin/openrgb --noautoconnect --device $i --mode static --color 000000
    done
  '';
in {
  hardware.enableAllFirmware = true;

  environment.systemPackages = with pkgs; [
    evtest
    hdparm
    lm_sensors
    pciutils
    smartmontools
    usbutils
    upower
    liquidctl
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot.kernelModules = [
    "nct6775"
    "i2c-dev"
  ];

  programs.coolercontrol.enable = true;

  services.udev.packages = [pkgs.openrgb];
  hardware.i2c.enable = true;

  systemd.services.no-rgb = {
    description = "no-rgb";
    serviceConfig = {
      ExecStart = "${no-rgb}/bin/no-rgb";
      Type = "oneshot";
    };
    wantedBy = ["multi-user.target"];
  };

  #services.hardware.openrgb = {
  #enable = true;
  #package = pkgs.openrgb-with-all-plugins;
  #motherboard = "amd";
  #startupProfile = "Zozano";
  #};

  # systemd.user.services.openrgb-profile = {
  #   description = "Apply OpenRGB profile";
  #   wantedBy = ["multi-user.target"];
  #   after = ["openrgb.service"];
  #   requires = ["openrgb.service"];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStartPre = "${pkgs.coreutils}/bin/sleep 5";
  #     ExecStart = "${pkgs.openrgb}/bin/openrgb --profile Default.orp.ba";
  #   };
  # };

  zramSwap.enable = true;
}
