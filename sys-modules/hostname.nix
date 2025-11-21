{ config, pkgs, lib, ... }:

let
  setHost = pkgs.writeShellScript "derive-hostname" ''
#!/usr/bin/env bash
set -euo pipefail

serial=""

if [ -r /sys/class/dmi/id/product_serial ]; then
  raw=$(tr -d ' \n' </sys/class/dmi/id/product_serial || true)

  # Normalise and filter out junk values
  case "$raw" in
    "" \
    | "ToBeFilledByOem" \
    | "ToBeFilledByOEM" \
    | "SystemSerialNumber" \
    | "Defaultstring")
      raw=""
      ;;
  esac

  # Require at least one digit; many placeholders are all letters
  if printf '%s' "$raw" | grep -q '[0-9]'; then
    serial="$raw"
  fi
fi

# Fallback to machine-id if serial is empty or junk
if [ -z "$serial" ] && [ -r /etc/machine-id ]; then
  serial=$(cut -c1-8 /etc/machine-id || true)
fi

short=""
if [ -n "$serial" ]; then
  short=$(printf '%s' "$serial" | tail -c 6 | tr '[:upper:]' '[:lower:]')
fi

name="dectech-$short"

current=$(cat /proc/sys/kernel/hostname 2>/dev/null || true)
if [ "$current" != "$name" ]; then
  /run/current-system/sw/bin/hostname "$name"
fi

  '';
in {
  # do not write /etc/hostname
  networking.hostName = lib.mkForce "";

  # run before networking is brought up
systemd.services.dynamic-hostname = {
  wantedBy = [ "sysinit.target" ];
  unitConfig = {
    DefaultDependencies = false;
    Before = [
      "basic.target"
      "network-pre.target"
      "prometheus-node-exporter.service"
      "sshd.service"
      "getty.target"
    ];
    After = [ "local-fs.target" ];
  };
  serviceConfig = {
    Type = "oneshot";
    ExecStart = "${setHost}";
    Restart = lib.mkForce "no";
  };
};

  # prevent NM from messing with the transient hostname
  networking.networkmanager.settings.main."hostname-mode" = "none";  # disables NM’s transient-hostname updates. :contentReference[oaicite:1]{index=1}

  # if you use dhcpcd instead of NM, disable its hostname writes
  # it only writes when the hostname is empty/localhost/nixos
  # networking.dhcpcd.setHostname = false;  # option exists; default true. :contentReference[oaicite:2]{index=2}
}
