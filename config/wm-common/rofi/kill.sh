#!/bin/bash
# by @metwse
# feel free to use without credit

if [ -z "$1" ]; then
    rofi -modi combi -combi-modi "run,drun,pk:$0 list" -combi-display-format '{mode}{text}' -display-combi '$' -display-drun 'd ' -display-run '' -show
elif [ -z "$2" ]; then 
    echo -en "\0prompt\n"
    ps -u $USER -o comm= | sort | uniq | sed 's/^/pk /;'
else
    pkill -9 $(echo $2 | cut -c 4-)
fi
