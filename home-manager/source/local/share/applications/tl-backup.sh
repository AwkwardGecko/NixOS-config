#!/run/current-system/sw/bin/bash

cd "/steam/SteamLibrary/steamapps/compatdata/41500/pfx/drive_c/users/steamuser/AppData/Roaming/runic games/"

mv torchlight.tar.gz old-backups/torchlight${date -d "today" +"%Y-%m-%d_%H-%M").tar.gz"

tar -czvf torchlight.tar.gz torchlight/
