#!/usr/bin/env bash

BASE="$HOME/.var/app/moe.launcher.the-honkers-railway-launcher/data/honkers-railway-launcher"

export WINEPREFIX="$BASE/prefix"
export WINEFSYNC=1
export WINE_FULLSCREEN_FSR=1
export WINE_FULLSCREEN_FSR_STRENGTH=2

WINE="$BASE/runners/spritz-wine-tkg-staging-wow64-10.15-8/bin/wine"
JADEITE="$BASE/patch/jadeite.exe"
GAME="$BASE/HSR/StarRail.exe"

"$WINE" "$JADEITE" "$GAME" -window-mode exclusive
