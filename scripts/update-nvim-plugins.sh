#!/usr/bin/env bash

rm ~/.config/nvim/lazy-lock.json

nvim --headless "+Lazy! sync" +qa # update Nvim Plugins
