#!/bin/bash

solrversion2date() {
    if [ $# -eq 1 ]; then
        date -r `expr $1 / 1024 / 1024 / 1000`
    fi
}

has() {
    if [ $# -ne 0 ]; then
       xargs grep -i "$1" | awk -F':' '{print $1}' | sort -u
    fi
}

