mkdir -p ~/.local/bin
cat > ~/.local/bin/sunshine-steam-bp << 'EOF'
#!/usr/bin/env bash
export DISPLAY=:0
export HOME=/home/zozano
export USER=zozano
export XDG_RUNTIME_DIR=/run/user/1000
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
export PATH=/run/current-system/sw/bin:/run/wrappers/bin:$PATH
/run/current-system/sw/bin/steam steam://open/bigpicture
EOF
chmod +x ~/.local/bin/sunshine-steam-bp
