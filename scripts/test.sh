#!/usr/bin/env bash
echo "=== USB Devices (filtered for Plustek/scanner) ==="
lsusb 2>/dev/null | grep -iE 'plustek|scanner|07b3' || echo "No Plustek USB device found"

echo ""
echo "=== All USB Devices ==="
lsusb 2>/dev/null

echo ""
echo "=== SANE installed? ==="
command -v scanimage && scanimage --version || echo "scanimage not found"

echo ""
echo "=== SANE detected devices ==="
scanimage -L 2>&1 || echo "scanimage -L failed"

echo ""
echo "=== SANE backends available ==="
ls /etc/sane.d/ 2>/dev/null | head -30 || echo "No /etc/sane.d/"
echo "---"
find /nix/store -maxdepth 2 -name 'plustek*' -o -name 'sane-backends*' 2>/dev/null | tail -10

echo ""
echo "=== NixOS SANE config ==="
grep -riE 'sane|scanner|plustek' ~/.dotfiles/*.nix ~/.dotfiles/**/*.nix 2>/dev/null || echo "No SANE/scanner config found in dotfiles"

echo ""
echo "=== Current user groups ==="
id

echo ""
echo "=== udev rules for scanners ==="
find /etc/udev/rules.d/ /run/udev/rules.d/ -iname '*sane*' -o -iname '*scanner*' 2>/dev/null | head -10 || echo "None found"

echo ""
echo "=== Firmware files ==="
find /nix/store -maxdepth 3 -name 'Plustek*' -o -name 'plustek*fw*' 2>/dev/null | head -10 || echo "No Plustek firmware found in nix store"
