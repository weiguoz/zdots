#!/bin/bash

run_segment() {
    mm=$(( ($(date +%s) / 60) % 3 ))
    if [ $mm -eq 0 ]; then
        mydt=$(TZ="Europe/London" date +"%a %H:%M")
        echo "Lon, $mydt"
    else
        date +"%a %H:%M"
    fi
    return 0
}
