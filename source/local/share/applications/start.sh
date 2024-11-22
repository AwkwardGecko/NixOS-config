#/bin/bash

#sudo umount /mnt/luks
sudo cryptsetup open /dev/disk/by-uuid/c5e87ce4-523f-46b9-8735-c6e7545a6d56 luks
sudo mount /dev/mapper/luks /mnt/luks
# bash /mnt/luks/stable-diffusion/webui.sh

# bash webui.sh --medvram --ckpt /mnt/luks/models/Stable-diffusion/aZovyaPhotoreal_v2.safetensors
