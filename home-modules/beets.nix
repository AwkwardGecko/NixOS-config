{ config, lib, pkgs, ... }:
{
  programs.beets = {
    enable = true;
    settings = {
      directory = "/server/data/media/music";
      library = "${config.xdg.dataHome}/beets/music.db";
      
      per_disc_numbering = true;
      asciify_paths = true;
      
      replace = {
        "^\\." = "_";                 # no leading dot
        "[\\x00-\\x1F]" = "";         # strip control chars
        "[<>:\"\\?\\*\\|]" = "";      # strip Win-unsafe
        "\\s+$" = "";                 # trim trailing space
      };

      import = {
        move = true;
        write = true;
        incremental = true;
        incremental_skip_later = true;
        resume = "ask";
        quiet = true;
        quiet_fallback = "asis";
        log = "${config.xdg.stateHome}/beets/import.log";
      };
      match = {
        preferred = {
          original_year = true;
          media = [ "Digital Media|File" "CD" ];
        };
      };
      plugins = [
        "chroma"    # AcoustID / fingerprinting
        "fetchart"  # download cover art
        "embedart"  # embed art into files
        "lastgenre" # genre from Last.fm
        "lyrics"    # fetch lyrics
        "mbsync"    # sync MBIDs back and forth
        "duplicates"
        "replaygain"
        "scrub"
        "missing"
      ];
      chroma.auto = true;
      fetchart = {
        auto = true;
        cautious = true;
        minwidth = 500;
        sources = "coverart itunes amazon";
      };
      embedart.auto = true;
      lastgenre = {
        auto = true;
        canonical = true;
        source = "album";
      };
      lyrics = {
        auto = true;
        sources = "musixmatch genius";
        fallback = "";
      };
      replaygain = {
        "backend" = "ffmpeg";
        target_level = -18;
      };

      item_fields = {
        multidisc = "1 if disctotal > 1 else 0";
      };

      paths = {
        # Normal albums
        default = "$albumartist/%if{$year,$year - }$album/"
                  + "%if{$multidisc,$disc_}%if{$track,$track - }$title";

        # Various Artists / Compilations
        comp = "Compilations/%if{$year,$year - }$album/"
               + "%if{$multidisc,$disc_}%if{$track,$track - }$artist - $title";

        # Singles / loose tracks
        singleton = "Singles/$artist/%if{$track,$track - }$title";
      };

      ui = { color = true; };
    };
  };
}
