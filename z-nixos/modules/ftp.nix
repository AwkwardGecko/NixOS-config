{ config, pkgs, ... }:

{
  services.vsftpd = {
    enable = true;
    localUsers = true;
    writeEnable = true; # KOReader downloads only but harmless

    extraConfig = ''
      pasv_enable=YES
      pasv_min_port=50000
      pasv_max_port=50010
      allow_writeable_chroot=YES
    '';
  };

  users.users.ftpuser = {
    isSystemUser = true;
    createHome = true;
    home = "/srv/books";
    password = "changeme";
    description = "FTP KOReader";
  };

  # ensure dir exists
  systemd.tmpfiles.rules = [
    "d /srv/books 0755 ftpuser ftpuser -"
  ];

  networking.firewall.allowedTCPPorts = [ 21 ];
  networking.firewall.allowedTCPPortRanges = [
    { from = 50000; to = 50010; }
  ];
}

