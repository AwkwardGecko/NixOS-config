#!/bin/bash
sudo cryptsetup open /dev/disk/by-uuid/c5e87ce4-523f-46b9-8735-c6e7545a6d56 luks
sudo mount /dev/mapper/luks /mnt/luks
