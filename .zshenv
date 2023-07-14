#!/bin/bash

import() {
    if [ $# -le 1 -a -f $1 ]; then
        . $1
    fi
}

# 为了能够在vim 中使用 alias，把 alias 放置在 env 中
import ${HOME}/zdots/sh/functions.sh

# preview configuration for ohmyzsh(@w7u)
source ${HOME}/zdots/sh/entrance.sh
limit coredumpsize 0
setopt auto_list
setopt auto_menu
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE
setopt share_history # 在多个会话中共享历史命令行
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space

# https://unix.stackexchange.com/a/37182
setopt autocd

# specify the ruby version https://github.com/rbenv/rbenv/issues/939#issuecomment-253940228
# eval "$(rbenv init -)"
