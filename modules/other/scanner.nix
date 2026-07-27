{
  config,
  lib,
  pkgs,
  ...
}: {
  hardware.sane.enable = true;
  hardware.sane.brscan5 = {
    enable = true;
    netDevices.home = {
      model = "MFC-L2800DW";
      ip = "192.168.2.191";
    };
  };
  hardware.sane.extraBackends = [
    (pkgs.sane-airscan.overrideAttrs (old: {
      postInstall =
        (old.postInstall or "")
        + ''
          printf '\n[devices]\n"Brother MFC-L2800DW" = http://192.168.2.191/eSCL, eSCL\n' >> $out/etc/sane.d/airscan.conf
        '';
    }))
  ];

  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;

  users.users.zozano.extraGroups = ["scanner" "lp"];

  home-manager.users.zozano.home.packages = [pkgs.simple-scan];

  home-manager.users.zozano.wayland.windowManager.hyprland.settings.env = [
  "LD_LIBRARY_PATH,/etc/sane-libs"
];
}
