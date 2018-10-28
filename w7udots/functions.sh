#!/bin/bash

solrversion2date() {
    if [ $# -eq 1 ]; then
        date -r `expr $1 / 1024 / 1024 / 1000`
    fi
}

cs() {
    builtin cd "$1" && l
}

tellme() {
    # brew install terminal-notifier
    if [ $# -eq 0 ]; then
        terminal-notifier -title 't3rm!na1' -message '洪磊：执行完毕'
    else
        terminal-notifier -title 't3rm!na1' -message 'w7u：'$1
    fi
}

# funny for my little son
wgg() {
    i=0
    LOOP=$2
    while [ $i -lt ${LOOP} ]; do
        sl -a
        sl -l
        sl -F
        sl -c
    done
}
