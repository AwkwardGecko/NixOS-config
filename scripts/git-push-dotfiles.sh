#!/run/current-system/sw/bin/bash
set -euo pipefail

cd /home/zozano/.dotfiles
git add *
sleep 2
git commit -m "$(date '+%F_%H:%M:%S')"
sleep 2
git push github main
sleep 2
