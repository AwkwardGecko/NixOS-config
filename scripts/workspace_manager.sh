#!usr/bin/env bash

current_workspace=$(hyprctl activeworkspace -j | jq '.id')
window_count=$(hyprctl workspaces -j | jq ".[] | select(.id == $current_workspace) | .windows")

if [ "$window_count" -ge 2 ]; then
    next_workspace=$(( (current_workspace % 10) + 1 ))
    hyprctl dispatch workspace $next_workspace
fi

hyprctl dispatch focuswindow address:$1

