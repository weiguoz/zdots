#!/bin/bash

import() {
    if [ $# -le 1 -a -f $1 ]; then
        . $1
    fi
}
