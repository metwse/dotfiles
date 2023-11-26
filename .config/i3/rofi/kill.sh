#!/bin/bash
# by @metwse
# feel free to use without credit

if [ -z "$@" ]; then
    echo -en "\0prompt\n"
    ps -u $USER -o comm= | sort | uniq | sed 's/^/pk /;'
else 
    pkill -9 $(echo $1 | cut -c 4-)
fi
