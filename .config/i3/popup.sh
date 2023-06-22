#!/bin/bash

while :; do
    id=$(i3-msg -t subscribe -m '[ "window" ]' | grep -m 1 -oP "\"change\":\"new\",\"container\":.*\"id\":\K(\d*)(?=.*\"window_role\":\"pop\-up\".*)")
    if [[ "$?" = 0 ]]; then
        i3-msg "[con_id=$id] floating enable; resize set width 720 px height 640 px; move position center; border none"
    else
        sleep 1
    fi
done
