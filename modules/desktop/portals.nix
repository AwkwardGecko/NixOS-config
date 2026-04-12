{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    kdePackages.dolphin
    kdePackages.okular
    kdePackages.kio-extras
    evince
    gedit
    gnome-calculator
    nomacs
    onlyoffice-desktopeditors
    #krusader
    krename # batch renamer for krusader
    nautilus # file browser
    shotwell
  ];

  home-manager.users.zozano = {
    programs.mpv.enable = true;
  };

  xdg = {
    mime = {
      enable = true;
      defaultApplications = {
        # find correct .desktop entries with:
        # ls /run/current-system/sw/share/applications/ | grep -i vlc

        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "image/*" = "org.nomacs.ImageLounge.desktop";
        "video/*" = "vlc.desktop";
        "application/pdf" = "org.pwmt.zathura.desktop";
        "text/*" = "org.gnome.gedit.desktop";
        "inode/directory" = "org.gnome.Nautilus.desktop";
      };
    };

    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
    };
  };
}
