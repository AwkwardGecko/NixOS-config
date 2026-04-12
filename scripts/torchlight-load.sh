#!/usr/bin/env bash
# torchlight-load.sh
SAVEDIR=~/.local/share/Steam/steamapps/compatdata/41500/pfx/drive_c/users/steamuser/AppData/Roaming/runic\ games/torchlight/save
LATEST=$(ls -dt ~/Games/Torchlight/*/ 2>/dev/null | head -1)

if [[ -z "$LATEST" ]]; then
  echo "No backups found in ~/Games/Torchlight/"
  exit 1
fi

echo "Loading: $LATEST"
rm -rf "$SAVEDIR"/*
cp -r "$LATEST"* "$SAVEDIR"/
