# DOTS defined in entrance.sh
# sourced by ~/.bashrc normally
# just4fun
alias woman='navi'
# here we go
alias md5sum='md5 -r'
alias diff='icdiff'
alias cp='cp -i'
alias ls='exa'
alias ll='ls -l'
alias lh='ls -ld .?*' # ls hidden files
alias has='xargs grep -Hli' # xargs grep -i "$1" | awk -F':' '{print $1}' | sort -u
alias sah='xargs grep -HLi'
alias grep='grep --color=always' # -i -n -m(max=8)
alias of='open -a Finder .'
alias ff='find . -type f -iname'
# alias fn='find . ! -wholename'

# login +++
alias sin='LC_ALL="zh_CN.GBK" luit ${DOTS}/ssh-helper/bastion_with_cookie.exp'  # running in tmux with luit
alias sin2='export LC_ALL="zh_CN.GBK" && ${DOTS}/ssh-helper/bastion_with_cookie.exp; export LC_ALL="en_US.UTF-8"'
alias arcsin='${DOTS}/ssh-helper/bastion.exp'
alias cos='${DOTS}/ssh-helper/sin.sh'
alias arccos='sh ${DOTS}/ssh-helper/rcp_id_rsa_pub.sh'
# login ---
alias mvnp='mvn clean package -Dmaven.test.skip'
alias antlr4='java -jar /usr/local/lib/antlr-4.5.3-complete.jar'
alias b='sh ${DOTS}/sh/search_on_terminal.sh'
# alias cd.
#  Q: why not recursion, such as .9='.. && .8' ?
#  A: have a look at 'cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias vi='vim +'
alias t='tmux'
alias bat='bat --theme=Dracula --style=numbers,changes --italic-text=always'

# if [ -f ${DOTS}/z/z.sh ]; then
#     z_then_ls() {
#         z "$1" && l
#     }
#     alias z='z_then_ls'
# fi

# package name: osascript -e 'id of app "Finder"'
# du -d 1 | sort -nr | head -3
