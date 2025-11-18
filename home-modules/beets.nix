{ config, lib, pkgs, ... }:
{
  programs.beets = {
    enable = true;
    settings = {
      directory = "/server/data/media/music-sorted";
      library = "${config.xdg.dataHome}/beets/music.db";
      import = {
        copy = false;
        move = true;
        write = true;
        timid = false;
        log = "${config.xdg.stateHome}/beets/import.log";
        resume = "ask";
      };
      match = {
        preferred = {
          original_year = true;
          media = [ "CD" "Digital Media|File" ];
        };
      };
      plugins = [
        "chroma"    # AcoustID / fingerprinting
        "fetchart"  # download cover art
        "embedart"  # embed art into files
        "lastgenre" # genre from Last.fm
        "lyrics"    # fetch lyrics
        "mbsync"    # sync MBIDs back and forth
        "duplicates"#
      ];
      chroma.auto = true;
      fetchart = {
        auto = true;
        cautious = true;
        minwidth = 500;
        sources = "itunes amazon coverart albumart";
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
      mbsync = {
        auto = true;
      };
      paths = {
        # Normal albums
        default = "%asciify{$albumartist}/%if{$year,$year - }$album/"
          + "%if{$disc_total,Disc $disc/}"
          + "%if{$track,$track - }$title";

        # Various Artists / compilations
        comp = "Compilations/%if{$year,$year - }$album/"
          + "%if{$track,$track - }$artist - $title";

        # Singles / loose tracks
        singleton = "Singles/%asciify{$artist}/$title";
      };
      replace = {
        # basic filename sanitisation
        "[\\\\/]" = "-";
        "^[.]"    = "_";
      };
    };
  };
}
