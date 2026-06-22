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
  ];

  programs.coolercontrol.enable = true;

  systemd.user.services.openrgb-profile = {
    description = "Apply OpenRGB profile";
    wantedBy = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "oneshot";
      # retry until the SDK server is actually accepting connections
      ExecStart = "${pkgs.openrgb}/bin/openrgb --client --profile Zozano";
      # crude but reliable: wait for the port, then apply
      ExecStartPre = "${pkgs.bash}/bin/sh -c 'for i in $(seq 1 30); do ${pkgs.openrgb}/bin/openrgb --noautoconnect --list-devices >/dev/null 2>&1 && exit 0; sleep 1; done; exit 0'";
      Restart = "on-failure";
      RestartSec = 2;
    };
    unitConfig.StartLimitBurst = 5;
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
