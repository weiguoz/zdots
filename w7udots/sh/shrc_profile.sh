#!/bin/bash

import() {
    if [ $# -le 1 -a -f $1 ]; then
        . $1
    fi
}

DOTS='/Users/weiguo/w7udots'


import ~/.fzf.zsh # https://github.com/junegunn/fzf
#eval $(thefuck --alias)
import ${DOTS}/z/z.sh # https://github.com/rupa/z
import ${DOTS}/sh/exports.sh
import ${DOTS}/sh/settings.sh
import ${DOTS}/sh/init.sh
import ${DOTS}/sh/alias.sh
# import /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
# export PS1='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
# uptime
