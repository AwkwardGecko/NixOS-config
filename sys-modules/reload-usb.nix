{ pkgs, config, lib, ... }:

{
  systemd.services.reload-usb-dongle = {
    description = "Reload USB HID driver";
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-udevd.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.kmod}/bin/modprobe -r usbhid && ${pkgs.kmod}/bin/modprobe usbhid";
      Restart = false;
    };
  };
}

