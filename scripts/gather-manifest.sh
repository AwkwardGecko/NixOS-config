#!/usr/bin/env bash
# gather-manifest.sh — Phase 1 file census for the cross-device file project.
#
# READ-ONLY. This script never writes to, moves, or deletes any indexed file,
# and never touches Proton Drive contents (only lists metadata via rclone).
#
# Produces JSONL manifests you can reconcile later:
#   - manifest-local-<host>.jsonl   : path, size, mtime, sha256, (EXIF date for images)
#   - manifest-proton.jsonl         : path, size, mtime          (NO hashes/downloads)
#   - summary-<host>.txt            : human-readable space + category breakdown
#
# Usage:
#   ./gather-manifest.sh local  [ROOT]      # default ROOT = $HOME
#   ./gather-manifest.sh proton [REMOTE]    # default REMOTE = proton: (root, everything)
#   ./gather-manifest.sh both               # local on $HOME, then proton
#
# Requires: bash, find, stat, sha256sum, awk (coreutils). Optional: exiftool
# (EXIF dates — skipped with a notice if absent), rclone (proton mode only).

set -euo pipefail

OUTDIR="${OUTDIR:-$HOME/file-census}"
mkdir -p "$OUTDIR"
HOST="$(hostname)"

# JSON string escaper for arbitrary file paths (handles quotes, backslashes, control chars).
json_escape() {
  local s=$1
  s=${s//\\/\\\\}
  s=${s//\"/\\\"}
  s=${s//$'\t'/\\t}
  s=${s//$'\n'/\\n}
  s=${s//$'\r'/\\r}
  printf '%s' "$s"
}

have() { command -v "$1" >/dev/null 2>&1; }

scan_local() {
  local root="${1:-$HOME}"
  root="${root%/}"
  local out="$OUTDIR/manifest-local-${HOST}.jsonl"
  local sum="$OUTDIR/summary-${HOST}.txt"

  echo ">> Local scan of: $root"
  echo ">> Manifest: $out"
  : > "$out"

  local has_exif="no"
  if have exiftool; then has_exif="yes"; else
    echo "!! exiftool not found — image EXIF dates will be skipped (install: nix-shell -p exiftool)"
  fi

  # Skip volatile/noise dirs that pollute a census. Adjust to taste.
  # Pruned: caches, VCS internals, node_modules, the Proton mirror, trash.
  local count=0
  while IFS= read -r -d '' f; do
    # stat: size + mtime epoch
    local size mtime
    size=$(stat -c '%s' "$f" 2>/dev/null) || continue
    mtime=$(stat -c '%Y' "$f" 2>/dev/null) || continue

    local sha
    sha=$(sha256sum -- "$f" 2>/dev/null | awk '{print $1}') || sha=""

    # EXIF DateTimeOriginal for images, if exiftool present
    local exifdate=""
    if [ "$has_exif" = "yes" ]; then
      case "${f,,}" in
        *.jpg|*.jpeg|*.png|*.heic|*.tiff|*.tif|*.webp|*.cr2|*.nef|*.arw|*.dng)
          exifdate=$(exiftool -s3 -DateTimeOriginal "$f" 2>/dev/null || true)
          ;;
      esac
    fi

    printf '{"path":"%s","size":%s,"mtime":%s,"sha256":"%s","exif":"%s"}\n' \
      "$(json_escape "$f")" "$size" "$mtime" "$sha" "$(json_escape "$exifdate")" >> "$out"

    count=$((count+1))
    if (( count % 2000 == 0 )); then echo "   ...$count files"; fi
  done < <(
    find "$root" \
      \( -path '*/.cache' -o -path '*/.git' -o -path '*/node_modules' \
         -o -path '*/.local/share/Trash' \
         -o -path '*/.steam' -o -path '*/.var' \) -prune -o \
      -type f -print0
  )

  echo ">> $count files indexed."

  # Human summary
  {
    echo "Census summary for $HOST — $(date -Iseconds)"
    echo "Root: $root"
    echo "Files indexed: $count"
    echo
    echo "Top-level disk usage (du):"
    du -h --max-depth=1 "$root" 2>/dev/null | sort -rh | head -30
    echo
    echo "Filesystem usage (df):"
    df -h "$root"
  } > "$sum"
  echo ">> Summary: $sum"
}

scan_proton() {
  local remote="${1:-proton:}"
  local out="$OUTDIR/manifest-proton.jsonl"

  if ! have rclone; then
    echo "!! rclone not found. Run this on the machine where your 'proton' remote is configured."
    exit 1
  fi

  echo ">> Proton listing (READ-ONLY metadata, no downloads): $remote"
  echo ">> Manifest: $out"

  # lsjson gives path/size/modtime as structured data without fetching contents.
  # --hash attempts server-side hashes; on E2E-encrypted Proton these are often
  # absent — that's expected and fine, we reconcile on path+size first.
  rclone lsjson -R --hash --files-only "$remote" 2>/dev/null \
    | tr -d '\n' \
    | sed 's/},{/}\n{/g; s/^\[//; s/\]$//' \
    > "$out" || {
      echo "!! rclone lsjson failed. Try a simpler listing:"
      echo "   rclone lsf -R --format 'pst' --separator '|' $remote > $OUTDIR/manifest-proton.psv"
      exit 1
    }

  local n
  n=$(wc -l < "$out" | tr -d ' ')
  echo ">> Proton entries listed: $n"
  echo ">> NOTE: Proton is E2E-encrypted; if the 'Hashes' field is empty, that's"
  echo ">>       expected. Reconciliation will match on path + size first."
}

case "${1:-}" in
  local)  scan_local  "${2:-$HOME}" ;;
  proton) scan_proton "${2:-proton:}" ;;
  both)   scan_local "$HOME"; scan_proton "proton:" ;;
  *) echo "Usage: $0 {local [ROOT] | proton [REMOTE] | both}"; exit 1 ;;
esac

echo ">> Done. Manifests in: $OUTDIR"
