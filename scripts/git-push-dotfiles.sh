#!/usr/bin/env bash
set -euo pipefail

cd /home/zozano/.dotfiles
git add *
git commit -m "$(date '+%F_%H:%M:%S')"
git push github main
