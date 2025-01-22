#!/run/current-system/sw/bin/bash

cd "/steam/SteamLibrary/steamapps/compatdata/41500/pfx/drive_c/users/steamuser/AppData/Roaming/runic games/"

mv torchlight.tar.gz old-backups/"${date +"%Y%m%d%H%M").tar.gz"

tar -czvf torchlight.tar.gz torchlight/
