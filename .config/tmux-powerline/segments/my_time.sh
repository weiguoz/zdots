#!/bin/bash

run_segment() {
    mm=$(( ($(date +%s) / 60) % 4 ))
    if [ $mm -lt 1 ]; then
        mydt=$(TZ="America/New_York" date +"%a %H:%M")
        echo "NY, $mydt"
    elif [ $mm -lt 2 ]; then
        mydt=$(TZ="Europe/London" date +"%a %H:%M")
        echo "Arsenal, $mydt"
    else
        date +"%a %H:%M"
    fi
    return 0
}
