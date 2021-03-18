#!/bin/bash

import() {
    if [ $# -le 1 -a -f $1 ]; then
        . $1
    fi
}

# 为了能够在vim中使用alias，所以把alias放置在env中
import ${HOME}/w7udots/sh/functions.sh
