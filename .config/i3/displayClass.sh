#!/bin/bash

p1=false

aosd_options='-p 4 -R white -B black -d 5 -x 0 -u 700 -f 0 -b 100'

while :; do
    i3-msg 
    if [[ "$?" = 0 ]]; then
        i3-msg -t subscribe -m '[ "window" ]' | 
        while read line; do
            window=$(echo $line | grep -m 1 -oP '^{"change":"focus".*"window_properties":\K.*}(?=.*)$')
            title=$(echo $window | grep -oP '.*"title":"\K.*?(?=",.*)')
            class=$(echo $window | grep -oP '.*"class":"\K.*?(?=",.*)')
            if [ ${#title} != 0 ]; then
                if [ p1 != false ]; then
                    kill -9 $p1; kill -9 $p2
                fi
                echo "» ${class^^} «" | aosd_cat $aosd_options -n "Monospace 16" -y -10 &
                p1=$!
                echo $title | aosd_cat $aosd_options -n "Monospace 12" -y 25 &
                p2=$!
            fi
        done < ${1:-/dev/stdin}
    else
        sleep 1
    fi
done
