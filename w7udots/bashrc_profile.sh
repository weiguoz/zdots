#!/bin/bash

import() {
    if [ $# -le 1 -a -f $1 ]; then
        . $1
    fi
}

MY_DOTS_IN='~/w7udots'

#eval $(thefuck --alias)
import ${MY_DOTS_IN}/z.sh # https://github.com/rupa/z
import ${MY_DOTS_IN}/exports.sh
import ${MY_DOTS_IN}/settings.sh
import ${MY_DOTS_IN}/alias.sh
import ${MY_DOTS_IN}/functions.sh
# import /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
# export PS1='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
uptime
