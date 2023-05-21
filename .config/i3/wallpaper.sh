#!/bin/bash

WEBKIT_DISABLE_COMPOSITING_MODE=1 ~/.config/i3/tabbed/tabbed -B -x "i3-msg restart" -o black -w $1 -g 1920x1080 -f surf -e $1 ~/.config/i3/wallpaper/index.html
