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
        echo "specify search engine with: [-b|-g] {query}"
        exit
        ;;
    -g)
        source ~/Documents/secrets/sensitive-env.sh
        web=${GitHomeSeachURL}
        ;;
    *)
        web="https://www.google.com/search?q="
        ;;
esac

for item in $*
do
    if [[ "$item" != "-h" && "$item" != "-b" && "$item" != "-g" ]]; then
        if [ "$searchWord" == "" ];then
            searchWord="$item"
        else
            searchWord="$searchWord $item"
        fi
    fi
done;
open "${web}${searchWord}"
