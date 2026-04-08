#!/usr/bin/env bash
cd ~/Proton-Drive
scanimage --device 'genesys:libusb:003:005' \
  --mode Color \
  --source "Transparency Adapter" \
  --resolution 7200 \
  --depth 16 \
  --format=tiff \
  -o scan.tiff
