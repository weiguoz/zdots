bindkey \^U backward-kill-line
# autoload -U compinit && compinit -u
# set -o vi # 长命令行使用esc进入vi模式编辑

bindkey ' ' magic-space

# bindkey.md https://gist.github.com/ssebastianj/dd4a42da5eee3304751712dc8aa1dc62
bindkey "^l" forward-word   # replaced by alt+b/f
bindkey "^h" backward-word
bindkey "^k" kill-line # it looks disabled >= big sur 11.2.1
bindkey -r '^j' # unbind
