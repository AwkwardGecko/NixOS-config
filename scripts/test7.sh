cat > ~/.config/sunshine/apps.json << 'EOF'
{
    "env": {
        "PATH": "$(PATH):$(HOME)/.local/bin",
        "WAYLAND_DISPLAY": "wayland-1",
        "DISPLAY": ":1"
    },
    "apps": [
        {
            "name": "Desktop",
            "image-path": "desktop.png"
        },
        {
            "name": "Steam Big Picture",
            "cmd": "steam -bigpicture",
            "image-path": "steam.png"
        }
    ]
}
EOF
