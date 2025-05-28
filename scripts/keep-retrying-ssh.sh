#/usr/bin/env bash

while ! ssh -t z-home@192.168.1.157 'fish -l'; do
  echo "SSH failed, retrying in 5 seconds..."
  sleep 5
done

