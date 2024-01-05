#!/bin/bash

import() {
    if [ $# -le 1 -a -f $1 ]; then
        . $1
    fi
}

# 为了能够在vim 中使用 alias，把 alias 放置在 env 中
import ${HOME}/zdots/sh/functions.sh

# preview configuration for ohmyzsh(@w7u)
source ${HOME}/zdots/sh/_.sh
limit coredumpsize 0
setopt auto_list
setopt auto_menu

# https://unix.stackexchange.com/a/37182
setopt autocd

# specify the ruby version https://github.com/rbenv/rbenv/issues/939#issuecomment-253940228
# eval "$(rbenv init -)"
. "$HOME/.cargo/env"
