# DOTS defined in entrance.sh
# sourced by ~/.bashrc normally
# just4fun
alias woman='navi'
# here we go
alias md5sum='md5 -r'
alias diff='icdiff'
alias cp='cp -i'
alias ls='exa'
alias ll='exa -l'
alias l='ranger'
alias lst='exa --long --tree'
alias lh='exa -ld .?*' # ls hidden files
alias has='xargs grep -Hli' # xargs grep -i "$1" | awk -F':' '{print $1}' | sort -u
alias sah='xargs grep -HLi'
alias grep='grep --color=always' # -i -n -m(max=8)
alias of='open -a Finder .'
alias ff='find . -type f -iname'
alias t='tmux'
alias code='/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code' # vscode
# alias fn='find . ! -wholename'

alias mvnp='mvn clean package -Dmaven.test.skip'
alias antlr4='java -jar /usr/local/lib/antlr-4.5.3-complete.jar'
alias b='sh ${DOTS}/sh/search_on_terminal.sh'
# alias cd.
#  Q: why not recursion, such as .9='.. && .8' ?
#  A: have a look at 'cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias vi='vim +'
alias bat='bat --theme=Dracula --style=numbers,changes --italic-text=always'
alias python3='python3.9'

# if [ -f ${DOTS}/z/z.sh ]; then
#     z_then_ls() {
#         z "$1" && l
#     }
#     alias z='z_then_ls'
# fi

# package name: osascript -e 'id of app "Finder"'
# du -d 1 | sort -nr | head -3
