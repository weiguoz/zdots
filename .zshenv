#!/bin/bash

import() {
    if [ $# -le 1 -a -f $1 ]; then
        . $1
    fi
}

# 为了能够在vim 中使用 alias，把 alias 放置在 env 中
import ${HOME}/zdots/sh/functions.sh
