bindkey \^U backward-kill-line
# autoload -U compinit && compinit -u
# set -o vi # 长命令行使用esc进入vi模式编辑

bindkey ' ' magic-space

bindkey "^w" forward-word
bindkey "^b" backward-word
bindkey '^l' autosuggest-accept # auto-suggestion
bindkey -M emacs '^k' history-substring-search-up
bindkey -M emacs '^j' history-substring-search-down
