#! /bin/sh sh

########################################################################################
# based on:                                                                            #
#   https://github.com/xiongwilee/search-on-terminal/blob/master/search_on_terminal.sh #
########################################################################################

if [ $# == 0 ]; then
    open -n -a "Google Chrome" && exit 0
fi

case $1 in
    -h)
        echo "specify search engine with: [-g] {query}"
        exit
        ;;
    -g)
        source ~/Documents/secrets/sensitive-env.sh
        url=${GitHomeSeachURL}
        ;;
    *)
        url="https://www.google.com/search?q="
        ;;
esac

for w in $*
do
    if [[ "$w" != "-h" && "$w" != "-g" ]]; then
        if [ "$searchWords" == "" ];then
            searchWords="$w"
        else
            searchWords="$searchWords $w"
        fi
    fi
done;
open "${url}${searchWords}"
