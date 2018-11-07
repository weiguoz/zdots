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
    LOOP=1
    if [ $# -gt 0 ]; then
        LOOP=$1
    fi
    while [ ${LOOP} -gt 0 ]; do
        sl -a
        sl -l
        sl -F
        sl -c
        LOOP=$[${LOOP}-1]
    done
}
