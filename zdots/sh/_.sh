#!/bin/bash

import() {
    local file="$1"
    if [ -n "$file" ] && [ -f "$file" ]; then
        # shellcheck source="$file"
        . "$file"
    fi
}


import "${HOME}/Documents/secrets/sh/_.sh"

DOTS="${HOME}/zdots"
import "${DOTS}/sh/exports.sh"
import "${DOTS}/sh/keybinding.sh"
import "${DOTS}/sh/init.sh"
import "${DOTS}/sh/search_on_terminal.sh"
import "${DOTS}/sh/alias.sh"
import "${DOTS}/sh/fzf.sh"
import "${DOTS}/sh/proxy.sh"


export HISTFILE=~/.zsh_history
export HISTSIZE=100080 # set history size
export SAVEHIST=100060 # save history after logout
setopt share_history
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY #add timestamp for each entry

# import /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
# export PS1='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
# uptime
# dig +short myip.opendns.com @resolver1.opendns.com
# unset DOTS
