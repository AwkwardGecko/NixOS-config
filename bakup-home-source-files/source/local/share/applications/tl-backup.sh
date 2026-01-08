#!/run/current-system/sw/bin/bash

cp /steam/SteamLibrary/steamapps/compatdata/41500/pfx/drive_c/users/steamuser/AppData/Roaming/runic\ games/torchlight.tar.gz /steam/SteamLibrary/steamapps/compatdata/41500/pfx/drive_c/users/steamuser/AppData/Roaming/runic\ games/old-backups/torchlight_$(date -d "today" +"%Y-%m-%d_%H-%M").tar.gz &&

# rm /steam/SteamLibrary/steamapps/compatdata/41500/pfx/drive_c/users/steamuser/AppData/Roaming/runic\ games/torchlight.tar.gz &&

tar -czvf torchlight.tar.gz torchlight/
