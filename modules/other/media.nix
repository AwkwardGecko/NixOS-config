{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    #digikam
    audacity
    ffmpeg
    gimp
    libheif
    qbittorrent
    strawberry
    vlc
    yt-dlp
    jellyfin-media-player
  ];

  home-manager.users.zozano = {
    home.packages = with pkgs; [
      playerctl
      mkvtoolnix # modify video files
      mp3gain # normalize volume of music
      mpc
      mpd-mpris
      ncmpcpp
    ];

    programs.yt-dlp = {
      enable = true;
      settings = {
        merge-output-format = "mkv";
        format = "bestvideo+bestaudio/best";
        embed-metadata = true;
        embed-thumbnail = true;
        embed-subs = true;
        sub-langs = "en";
        sponsorblock-mark = "all";
      };
    };

    services.mpd = {
      enable = true;
      musicDirectory = "/data/media/music";
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "pipeWire Output"
        }
      '';
    };

    xdg.desktopEntries.jellyfin-opener = {
      name = "Jellyfin Media Player Opener";
      exec = "jellyfin-desktop %u";
      type = "Application";
      noDisplay = true;
      mimeType = ["x-scheme-handler/jmp"];
    };

    xdg.mimeApps.defaultApplications = {
      "x-scheme-handler/jmp" = "jellyfin-opener.desktop";
    };

    systemd.user.services.mpd-mpris = {
      Unit.Description = "MPRIS bridge for MPD";
      Unit.After = ["mpd.service"];
      Service.ExecStart = "${pkgs.mpd-mpris}/bin/mpd-mpris";
      Service.Restart = "on-failure";
      Install.WantedBy = ["default.target"];
    };
  };
}
