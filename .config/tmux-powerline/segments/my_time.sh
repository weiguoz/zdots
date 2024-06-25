#!/bin/bash

run_segment() {
    mm=$(( ($(date +%s) / 120) % 3 ))
    if [ $mm -eq 0 ]; then
        mydt=$(TZ="Europe/Berlin" date +"%a %H:%M")
        echo "Berlin, $mydt"
    elif [ $mm -eq 1 ]; then
        date +"%a %H:%M"
    else
        mydt=$(TZ="America/New_York" date +"%a %H:%M")
        echo "NY, $mydt"
    fi
    return 0
}
