#!/bin/bash

proxy() {
    if [ $# -eq 0 ]; then
        echo "Bad command, specific {on,off} {server_tag_to_find_the_right_port}"
    elif [ $1 = "on" ]; then
        export https_proxy="http://127.0.0.1:7890" http_proxy="http://127.0.0.1:7890" all_proxy="socks5://127.0.0.1:7890"
        echo "HTTP Proxy on"
    elif [ $1 = "off" ]; then
        unset https_proxy http_proxy all_proxy
        echo "HTTP Proxy off"
    else
        echo "Bad command, specific {on,off} {server_tag_to_find_the_right_port}"
    fi
}
