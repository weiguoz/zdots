bindkey \^U backward-kill-line
# autoload -U compinit && compinit -u
# set -o vi # 长命令行使用esc进入vi模式编辑

bindkey ' ' magic-space

bindkey "^l" forward-word
bindkey "^h" backward-word
bindkey '^n' autosuggest-accept # auto-suggestion
