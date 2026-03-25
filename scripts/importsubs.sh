#!/usr/bin/env bash

find /data/media/movies /data/media/shows -name "*.mkv" | while read mkv; do
    dir=$(dirname "$mkv")
    base=$(basename "$mkv" .mkv)
    srts=("$dir/$base"*.srt)
    
    # Skip if no matching SRTs exist
    [[ -e "${srts[0]}" ]] || continue
    
    # Build ffmpeg input args for each SRT
    inputs=()
    maps=("-map" "0")
    meta=()
    i=1
    for srt in "${srts[@]}"; do
        inputs+=("-i" "$srt")
        maps+=("-map" "$i")
        # Try to extract language from filename (e.g. .en.srt, .ko.srt)
        lang=$(echo "$srt" | grep -oP '\.([a-z]{2,3})\.srt$' | grep -oP '[a-z]{2,3}')
        lang=${lang:-eng}
        meta+=("-metadata:s:s:$((i-1))" "language=$lang")
        ((i++))
    done
    
    ffmpeg -i "$mkv" "${inputs[@]}" "${maps[@]}" \
        -c copy "${meta[@]}" \
        "${mkv%.mkv}.tmp.mkv"
    
    if [[ $? -eq 0 ]]; then
        mv "${mkv%.mkv}.tmp.mkv" "$mkv"
        rm "${srts[@]}"
        echo "Done: $mkv"
    else
        rm -f "${mkv%.mkv}.tmp.mkv"
        echo "FAILED: $mkv"
    fi
done
