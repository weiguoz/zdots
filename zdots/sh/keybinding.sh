bindkey \^U backward-kill-line
# autoload -U compinit && compinit -u
# set -o vi # 长命令行使用esc进入vi模式编辑

bindkey ' ' magic-space

# bindkey.md https://gist.github.com/ssebastianj/dd4a42da5eee3304751712dc8aa1dc62
bindkey "^g" kill-word   # alt+d
bindkey "^l" forward-word   # alt+b/f
bindkey "^h" backward-word
bindkey "^k" kill-line # it looks disabled >= big sur 11.2.1
bindkey -r '^j' # unbind

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
# bindkey '\C-x\C-e' edit-command-line
bindkey '\C-v' edit-command-line

backward-kill-dir () {
    # https://stackoverflow.com/a/11200998/479812
    local WORDCHARS=
    # local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey "^w" backward-kill-dir

# bindkey -s '^o' 'vim $(fzf)^M' replace by ranger
# inspired by https://jdhao.github.io/2019/06/13/zsh_bind_keys/
bindkey -s '^o' 'my_fzf_rg^M'
