#!/bin/bash

import() {
    if [ $# -le 1 -a -f $1 ]; then
        . $1
    fi
}

DOTS='/Users/weiguo/w7udots'

# 为了能够在vim中使用alias，所以把alias放置在env中
import ${DOTS}/sh/functions.sh
