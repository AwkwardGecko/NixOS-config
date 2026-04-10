#!/usr/bin/env bash
SAVEPATH=~/.local/share/Steam/steamapps/compatdata/41500/pfx/drive_c/users/steamuser/AppData/Roaming/runic\ games/torchlight/save
BACKUP=~/Games/Torchlight/$(date +%Y-%m-%d_%H_%M_%S).png

cp -r "$SAVEPATH" "$BACKUP"
