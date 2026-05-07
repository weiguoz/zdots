# ~/zdots/sh/enhancd.sh
# enhancd integration.

export ENHANCD_FILTER='fzf --preview "eza -al --tree --level 1 --group-directories-first --git-ignore --header --git --no-user --no-time --no-filesize --no-permissions {}" --preview-window right,50% --height 35% --reverse --ansi'
