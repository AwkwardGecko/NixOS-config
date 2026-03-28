#!/usr/bin/env bash
export WINEPREFIX="$HOME/.var/app/moe.launcher.the-honkers-railway-launcher/data/honkers-railway-launcher/pfx"
export PATH="$HOME/.var/app/moe.launcher.the-honkers-railway-launcher/data/honkers-railway-launcher/runners/spritz-wine-tkg-staging-wow64-10.15-8/bin:$PATH"

wine "$HOME/.var/app/moe.launcher.the-honkers-railway-launcher/data/honkers-railway-launcher/HSR/StarRail.exe" -window-mode exclusive
