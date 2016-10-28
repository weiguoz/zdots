#!/bin/bash

solrversion2date() {
    if [ $# -eq 1 ]; then
        date -r `expr $1 / 1024 / 1024 / 1000`
    fi
}
