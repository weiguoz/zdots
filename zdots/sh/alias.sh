#!/bin/sh

# DOTS defined in entrance.sh
# sourced by ~/.bashrc normally
# here we go
alias md5sum='md5 -r'
alias top0='glances' # https://github.com/nicolargo/glances
alias diff='icdiff'
alias cp='cp -i'
alias ls='exa'
alias ll='exa -l'
alias l='ranger' # disable the bultin command `r` by the way
alias lst='exa --long --tree'
alias lh='exa -ld .?*' # ls hidden files
alias has='xargs grep -Hli' # xargs grep -i "$1" | awk -F':' '{print $1}' | sort -u
alias sah='xargs grep -HLi'
alias grep='grep --color=always' # -i -n -m(max=8)
alias vs='/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code' # vscode
alias vi='nvim'
alias vim='nvim +'
# alias fn='find . ! -wholename'
# open
alias o='sh ${DOTS}/sh/search_on_terminal.sh'
alias oh='o -g'
alias f='open -a Finder .'

alias mvnp='mvn clean package -Dmaven.test.skip'
# alias antlr4='java -jar /usr/local/lib/antlr-4.5.3-complete.jar'

# alias cd
### 我把 zdharma-continuum/fast-syntax-highlighting 移到enhancd之前，问题解决了，但又会有新的补全问题
### https://github.com/b4b4r07/enhancd
### 在 macOS 13.3 (22E252) a.k.a Ventura 中，enhancd 和补全有冲突，导致enhancd无法正常工作: https://github.com/b4b4r07/enhancd/issues/206
### 我考虑到 enhancd 完全可以替代 zlua( https://github.com/skywind3000/z.lua )，所以:
### 0) 删除 zlua
### 1) 直接将 z 定向到 enhancd
### 2) 将cd 由__enhancd::cd重新恢复为 builtin-cd
##alias z='__enhancd::cd'
##alias zh='pwd | tr -d "\r\n" | __enhancd::cd' # help creating ~/.enhancd/enhancd.log
##alias cd='builtin cd'

# https://github.com/sharkdp/bat
alias cat='bat --style=numbers,changes --italic-text=always' # --theme=Dracula
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
help() {
    "$@" --help 2>&1 | bat --plain --language=help
}
gitdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

# if [ -f ${DOTS}/z/z.sh ]; then
#     z_then_ls() {
#         z "$1" && l
#     }
#     alias z='z_then_ls'
# fi

# package name: osascript -e 'id of app "Finder"'
# du -d 1 -h | sort -nr | head -3
alias du='dua' # cargo install dua-cli
# Enhance shell by cheat.sh & navi
alias che='cht.sh --shell'
# eval "$(navi widget zsh)" # c-g call navi
