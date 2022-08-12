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
alias of='open -a Finder .'
alias ff='ffhelper(){if [ -n "$1" ]; then find . -type f -iname "$1"; else find . -type f -iname "*"; fi}; ffhelper'
alias t='tmux'
alias vs='/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code' # vscode
alias vim='nvim'
# alias fn='find . ! -wholename'

alias mvnp='mvn clean package -Dmaven.test.skip'
# alias antlr4='java -jar /usr/local/lib/antlr-4.5.3-complete.jar'
alias h='sh ${DOTS}/sh/search_on_terminal.sh -g'
# alias cd.
#  Q: why not recursion, such as .9='.. && .8' ?
#  A: have a look at 'cd -'
alias ...='cd ../..'

alias bat='bat --theme=Dracula --style=numbers,changes --italic-text=always'

# if [ -f ${DOTS}/z/z.sh ]; then
#     z_then_ls() {
#         z "$1" && l
#     }
#     alias z='z_then_ls'
# fi
# git
alias gitp='git pull -p'

# package name: osascript -e 'id of app "Finder"'
# du -d 1 -h | sort -nr | head -3
# Enhance shell by cheat.sh & navi
alias che='cht.sh --shell'
# eval "$(navi widget zsh)" # c-g call navi
