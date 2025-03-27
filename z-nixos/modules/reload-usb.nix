{ ... }:
systemd.services.reload-usb-dongle = {
  wantedBy = [ "multi-user.target" ];
  script = ''
    modprobe -r usbhid
    modprobe usbhid
  '';
};
