#!/bin/bash

solrversion2date() {
    if [ $# -eq 1 ]; then
        date -r `expr $1 / 1024 / 1024 / 1000`
    fi
}

cds() {
    builtin cd "$1" && l
}

tellme() {
    # brew install terminal-notifier
    msg="done"
    if [ $# -ne 0 ]; then
        msg=$1
    fi
    terminal-notifier -title 't3rm!na1' -message 'w7u：'$msg
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

pc() {
    pc_usage() { echo "pc -p {pane} -c {command}" >&2; }

    local OPTIND
    while getopts ":p:c:" opt; do
        case "${opt}" in
            p ) # pane
                p="$OPTARG"
                ;;
            c )
                c="$OPTARG"
                ;;
            \? )
                echo "Invalid option: -$OPTARG" >&2
                ;;
            : )
                pc_usage
        esac
    done
    shift $((OPTIND-1))

    if [ -z "$p" -o -z "$c" ]; then
        pc_usage
    else
        tmux send-keys -t$p "$c" enter
    fi
}
