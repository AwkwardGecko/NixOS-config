#!/usr/bin/env bash

# Get the current directory of the image
dir="$(dirname "$1")"

# Collect the images in the directory
images=($(find "$dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | sort))

# Find the index of the current image
index=0
for i in "${!images[@]}"; do
    if [[ "${images[$i]}" == "$1" ]]; then
        index=$i
        break
    fi
done

# Start Feh with the images and the ability to delete on pressing the delete key
feh --fullscreen --action "rm ${images[$index]} && feh --reload" --index $index "${images[@]}"

