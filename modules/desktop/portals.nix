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
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "image/*" = "nomacs";
        "image/png" = "nomacs";
        #"image/jpeg" = "imv.desktop";
        #"image/gif" = "nomacs.desktop";
        "video/*" = "vlc.desktop";
        #"video/mp4" = "mpv.desktop";
        #"video/x-matroska" = "mpv.desktop";
        "application/pdf" = "org.pwmt.zathura.desktop";
        "text/*" = "gedit.desktop";
        "inode/directory" = "nautilus.desktop";
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
