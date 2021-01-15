my_prx() {
    if [ $# -eq 0 ]; then
        echo "Bad command, specific {on,off} {server_tag_to_find_the_right_port}"
    elif [ $1 = "on" ]; then
        server_tag=$2
        proxy=$(lsof -i -n -P | grep LISTEN | grep ${server_tag} | tr -s ' ' | cut -d' ' -f 9)
        if ([ -z "$proxy" ]); then
            echo "Can't find a proxy server"
        else
            export http_proxy="$proxy"
            export https_proxy="$proxy"
            echo "Terminal proxy is: $proxy"
        fi
    elif [ $1 = "off" ]; then
        unset http_proxy
        unset https_proxy
        echo 'Shutdown proxy on terminal'
    else
        echo "Bad command, specific {on,off} {server_tag_to_find_the_right_port}"
    fi
}
