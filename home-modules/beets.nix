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

  home.file."bin/beets-maintain" = {
    text = ''
      #!${pkgs.bash}/bin/bash
      set -euo pipefail

      MUSIC_LIB="/server/data/media/music"
      INBOX="/server/data/media/music-sorted"
      DUPS="/server/data/media/music-duplicates"
      LOG_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/beets"

      mkdir -p "$MUSIC_LIB" "$INBOX" "$DUPS" "$LOG_DIR"

      echo "[beets-maintain] 1/9 Importing from inbox: $INBOX"
      # NOTE: we do *not* use -A. -A disables autotagging.
      beet import -q -i "$INBOX"

      echo "[beets-maintain] 2/9 Normalizing paths into library: $MUSIC_LIB"
      beet move -a

      echo "[beets-maintain] 3/9 Syncing existing MBIDs with MusicBrainz"
      beet mbsync

      echo "[beets-maintain] 4/9 Generating / refreshing fingerprints"
      beet fingerprint

      echo "[beets-maintain] 5/9 Detecting and moving duplicates → $DUPS"
      # This uses the duplicates plugin defaults (MBIDs, then artist/title/length).
      beet duplicates -m "$DUPS" || true

      echo "[beets-maintain] 6/9 Writing tags and scrubbing weirdness"
      # -a = albums; -f = force rewrite even if beets thinks tags are current
      beet write -af

      echo "[beets-maintain] 7/9 Artwork, genres, lyrics"
      beet fetchart
      beet embedart
      beet lastgenre
      # Lyrics providers can be flaky; don't fail the whole run on errors
      beet lyrics || true

      echo "[beets-maintain] 8/9 Calculating ReplayGain"
      beet replaygain

      echo "[beets-maintain] 9/9 Final DB resync (no moves)"
      # -M: don’t move/rename files during update, just sync metadata & detect
      # missing files in the DB.
      beet update -aM

      echo "[beets-maintain] Done. Library should now be in a consistent state."
    '';
    executable = true;
  };

}
