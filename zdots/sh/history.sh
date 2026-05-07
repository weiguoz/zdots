# ~/zdots/sh/history.sh
# Zsh history settings.

export HISTFILE="${HISTFILE:-$HOME/.zsh_history}"

HISTSIZE=40000
SAVEHIST=20000

setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt NO_HIST_BEEP
