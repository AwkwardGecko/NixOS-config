#!/usr/bin/env bash
cd ~/Proton-Drive
scanimage --device 'genesys:libusb:003:005' \
  --mode Color \
  --source "Transparency Adapter" \
  --resolution 3600 \ # half res
  --format=png \
  -o scan_$(date +%Y-%m-%d_%H_%M_%S).png

  # super high def
  # --resolution 7200 \
  # --depth 16 \
  # --format=tiff \
  # -o scan_$(date +%Y-%m-%d_%H_%M_%S).png
