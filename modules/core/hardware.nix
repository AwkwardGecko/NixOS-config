{
  config,
  lib,
  pkgs,
  ...
}: {
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

  boot.kernelModules = ["nct6775"];

  programs.coolercontrol.enable = true;

  services.hardware.openrgb = {
    enable = true;
    #motherboard = "amd";
    #startupProfile = "Zozano";
  };

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
