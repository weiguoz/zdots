bindkey ^U backward-kill-line
# autoload -U compinit && compinit -u
# set -o vi # 长命令行使用esc进入vi模式编辑

bindkey ' ' magic-space
bindkey "^l" forward-word   # alt+b/f
bindkey "^k" kill-line # it looks disabled >= big sur 11.2.1
bindkey -r '^j' # unbind

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
# bindkey '\C-x\C-e' edit-command-line
bindkey '\C-v' edit-command-line

# {{{ User Defined
# bindkey.md https://gist.github.com/ssebastianj/dd4a42da5eee3304751712dc8aa1dc62
my-backward-kill-word() {
    # https://stackoverflow.com/a/11200998/479812
    # local WORDCHARS=${WORDCHARS/\/}
    local WORDCHARS=
    zle backward-kill-word
}
zle -N my-backward-kill-word
bindkey "^w" my-backward-kill-word

my-forward-kill-word () {
    local WORDCHARS=
    zle kill-word
}
zle -N my-forward-kill-word
bindkey "^g" my-forward-kill-word   # alt+d

my-backward-word () {
    local WORDCHARS=
    zle backward-word
}
zle -N my-backward-word
bindkey "^h" my-backward-word
# }}}

# bindkey -s '^o' 'vim $(fzf)^M' replace by ranger
# inspired by https://jdhao.github.io/2019/06/13/zsh_bind_keys/
bindkey -s '^o' 'my_fzf_rg^M'
