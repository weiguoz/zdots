bindkey \^U backward-kill-line
# autoload -U compinit && compinit -u
# set -o vi # 长命令行使用esc进入vi模式编辑

bindkey ' ' magic-space

# bindkey "^l" forward-word   # replaced by alt+b/f
# bindkey "^h" backward-word
# bindkey "^j" autosuggest-accept # auto-e uggestion. c-e
bindkey '^j' forward-word
# bindkey '^b' backward-word c-w
