#! /bin/sh sh

########################################################################################
# based on:                                                                            #
#   https://github.com/xiongwilee/search-on-terminal/blob/master/search_on_terminal.sh #
########################################################################################

if [ $# == 0 ]; then
    open "http:"
    exit
fi

case $1 in
    -h)
        echo "specify search engine with: -h/b/g/npm"
        exit
        ;;
    -b)
        web="https://www.baidu.com/s?wd="
        ;;
    -g)
        source ~/Documents/secret.sh
        web=${GitHomeSeachURL}
        ;;
    -npm)
        web="https://www.npmjs.com/search?q="
        ;;
    *)
        web="https://www.google.com/search?q="
        ;;
esac

for item in $*
do
    if [[ "$item" != "-h" && "$item" != "-b" && "$item" != "-g" && "$item" != "-npm" ]]; then
        if [ "$searchWord" == "" ];then
            searchWord="$item"
        else
            searchWord="$searchWord $item"
        fi
    fi
done;
open "${web}${searchWord}"
