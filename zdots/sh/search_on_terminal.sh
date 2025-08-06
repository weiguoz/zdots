#!/bin/bash

########################################################################################
# based on:                                                                            #
#   https://github.com/xiongwilee/search-on-terminal/blob/master/search_on_terminal.sh #
########################################################################################

o() {
    if [ $# -eq 0 ]; then
        open -a "Safari" # open -n -a "Safari" "Google Chrome Beta" && exit 0
        return
    fi

    local url w searchWords
    case $1 in
        -h)
            echo "specify search engine with: [-g] {query}" ; return ;;
        -g)
            url=${GitHomeSeachURL} ;;
        *)
            url="https://www.google.com/search?q=" ;;
    esac

    for w in "$@"
    do
        if [[ "$w" != "-h" && "$w" != "-g" ]]; then
            if [ "$searchWords" = "" ];then
                searchWords="$w"
            else
                searchWords="$searchWords $w"
            fi
        fi
    done;
    open "${url}${searchWords}"
}

alias oh='o -g'
