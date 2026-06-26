# ~/.dotfiles/modules/shazam.nix
{pkgs, ...}: let
  # Shazam-based music indexer: runs SongRec (file mode) over audio files,
  # parses the JSON, writes tags, and files into the indexed tree.
  # Intended for the _needs-review/ pile that AcoustID (fpindex) could not match.
  # Existing file metadata is NEVER read for identification.
  fpshazam =
    pkgs.writers.writePython3Bin "fpshazam"
    {
      libraries = [pkgs.python3Packages.mutagen];
      doCheck = false;
    } ''
      import os, sys, shutil, time, json, argparse, re, subprocess

      OUTPUT  = os.environ.get("FPINDEX_OUTPUT", "/data/music-indexed-with-beets")
      REVIEW  = os.path.join(OUTPUT, "_needs-review")
      THROTTLE = float(os.environ.get("FPSHAZAM_THROTTLE", "2.0"))  # seconds between Shazam calls
      SONGREC = os.environ.get("SONGREC_BIN", "songrec")
      EXTS    = {".m4a", ".mp3", ".flac", ".opus", ".ogg", ".wav", ".aac", ".wma"}

      def sanitize(s):
          s = re.sub(r'[/\x00]', '_', s or "")
          return s.strip() or "Unknown"

      def dest_path(artist, title, ext):
          d = os.path.join(OUTPUT, sanitize(artist))
          os.makedirs(d, exist_ok=True)
          base = sanitize(title)
          p = os.path.join(d, base + ext)
          n = 2
          while os.path.exists(p):
              p = os.path.join(d, f"{base}-{n}{ext}")
              n += 1
          return p

      def write_tags(path, fields):
          # fields: dict with optional keys title, artist, album, genre, date, label, isrc
          from mutagen import File as MutagenFile
          from mutagen.mp4 import MP4
          from mutagen.id3 import ID3, TIT2, TPE1, TALB, TCON, TDRC, TPUB, TSRC
          from mutagen.flac import FLAC
          ext = os.path.splitext(path)[1].lower()
          try:
              if ext in (".m4a", ".aac"):
                  a = MP4(path)
                  m = {
                      "title": "\xa9nam", "artist": "\xa9ART", "album": "\xa9alb",
                      "genre": "\xa9gen", "date": "\xa9day",
                  }
                  for k, atom in m.items():
                      if fields.get(k):
                          a[atom] = [fields[k]]
                  # label + isrc have no standard MP4 atom; store as freeform
                  if fields.get("label"):
                      a["----:com.apple.iTunes:LABEL"] = [fields["label"].encode("utf-8")]
                  if fields.get("isrc"):
                      a["----:com.apple.iTunes:ISRC"] = [fields["isrc"].encode("utf-8")]
                  a.save()
              elif ext == ".mp3":
                  try:
                      a = ID3(path)
                  except Exception:
                      a = ID3()
                  if fields.get("title"):  a.add(TIT2(encoding=3, text=fields["title"]))
                  if fields.get("artist"): a.add(TPE1(encoding=3, text=fields["artist"]))
                  if fields.get("album"):  a.add(TALB(encoding=3, text=fields["album"]))
                  if fields.get("genre"):  a.add(TCON(encoding=3, text=fields["genre"]))
                  if fields.get("date"):   a.add(TDRC(encoding=3, text=fields["date"]))
                  if fields.get("label"):  a.add(TPUB(encoding=3, text=fields["label"]))
                  if fields.get("isrc"):   a.add(TSRC(encoding=3, text=fields["isrc"]))
                  a.save(path)
              elif ext == ".flac":
                  a = FLAC(path)
                  fmap = {
                      "title": "TITLE", "artist": "ARTIST", "album": "ALBUM",
                      "genre": "GENRE", "date": "DATE", "label": "LABEL", "isrc": "ISRC",
                  }
                  for k, vk in fmap.items():
                      if fields.get(k):
                          a[vk] = fields[k]
                  a.save()
              else:
                  a = MutagenFile(path, easy=True)
                  if a is None:
                      return False
                  for k in ("title", "artist", "album", "genre", "date"):
                      if fields.get(k):
                          a[k] = fields[k]
                  a.save()
              return True
          except Exception as e:
              print(f"  ! tag write failed: {e}", file=sys.stderr)
              return False

      def run_songrec(path):
          try:
              out = subprocess.run(
                  [SONGREC, "audio-file-to-recognized-song", path],
                  capture_output=True, text=True, timeout=60,
              )
          except subprocess.TimeoutExpired:
              return None, "timeout"
          except FileNotFoundError:
              print("ERROR: songrec not found on PATH", file=sys.stderr)
              sys.exit(1)
          if out.returncode != 0:
              return None, f"songrec exit {out.returncode}"
          try:
              data = json.loads(out.stdout)
          except json.JSONDecodeError:
              return None, "bad json"
          return data, None

      def parse(data):
          # Returns a fields dict, or None if no track was identified.
          track = data.get("track")
          if not track or not track.get("title"):
              return None
          fields = {}
          fields["title"] = track.get("title")
          fields["artist"] = track.get("subtitle")        # Shazam puts artist here
          fields["genre"] = (track.get("genres") or {}).get("primary")
          fields["isrc"] = track.get("isrc")
          # album / label / year live in sections[type=SONG].metadata[]
          for sec in track.get("sections", []):
              if sec.get("type") == "SONG":
                  for md in sec.get("metadata", []):
                      t = (md.get("title") or "").lower()
                      val = md.get("text")
                      if t == "album":
                          fields["album"] = val
                      elif t == "label":
                          fields["label"] = val
                      elif t == "released":
                          fields["date"] = val
          # drop empty keys
          return {k: v for k, v in fields.items() if v}

      def main():
          ap = argparse.ArgumentParser()
          ap.add_argument("roots", nargs="*", default=[REVIEW],
                          help="dirs/files to process (default: the _needs-review pile)")
          ap.add_argument("--apply", action="store_true",
                          help="actually move/tag files (default: dry run)")
          ap.add_argument("--move", action="store_true",
                          help="move instead of copy (removes from review on success)")
          args = ap.parse_args()
          roots = args.roots or [REVIEW]

          files = []
          for root in roots:
              if os.path.isfile(root):
                  if os.path.splitext(root)[1].lower() in EXTS:
                      files.append(root)
              else:
                  for dp, _, fns in os.walk(root):
                      for fn in fns:
                          if os.path.splitext(fn)[1].lower() in EXTS:
                              files.append(os.path.join(dp, fn))

          print(f"[*] {len(files)} audio files. "
                f"mode={'APPLY' if args.apply else 'DRY-RUN'} "
                f"op={'move' if args.move else 'copy'} throttle={THROTTLE}s")

          stats = {"id": 0, "none": 0, "err": 0}
          for i, path in enumerate(files, 1):
              ext = os.path.splitext(path)[1].lower()
              data, err = run_songrec(path)
              time.sleep(THROTTLE)  # be gentle with the unofficial Shazam endpoint
              if err:
                  print(f"[{i}] ERR  {err}  {path}")
                  stats["err"] += 1
                  continue
              fields = parse(data)
              if fields is None:
                  print(f"[{i}] NONE          {path}")
                  stats["none"] += 1
                  continue
              tag = f"{fields.get('artist','?')} - {fields.get('title','?')}"
              extra = []
              if fields.get("album"): extra.append(fields["album"])
              if fields.get("date"):  extra.append(fields["date"])
              suffix = f"  [{' / '.join(extra)}]" if extra else ""
              print(f"[{i}] OK   {tag}{suffix}")
              stats["id"] += 1
              if args.apply:
                  dst = dest_path(fields.get("artist"), fields.get("title"), ext)
                  if args.move:
                      shutil.move(path, dst)
                  else:
                      shutil.copy2(path, dst)
                  write_tags(dst, fields)

          print(f"\n[done] identified={stats['id']} none={stats['none']} err={stats['err']}")

      if __name__ == "__main__":
          main()
    '';
in {
  home-manager.users.zozano.home.packages = [
    fpshazam
    pkgs.songrec
    pkgs.ffmpeg
    (pkgs.python3.withPackages (ps: [ps.mutagen]))
  ];
}
