DOTS="/Users/weiguo/w7udots"
# sourced by ~/.bashrc normally
# just4fun
alias woman='man'
alias calc='bc'
# here we go
alias diff='icdiff'
alias md5sum='md5 -r'
alias ls='ls -pFGh'
alias l='ls -l'
alias ll='ls -al'
alias la='ls -a'
alias lsh='ls -ld .?*' # ls hidden files
alias has='xargs grep -Hli' # xargs grep -i "$1" | awk -F':' '{print $1}' | sort -u
alias sah='xargs grep -HLi'
# alias grep='grep --color=always -n' # -i -n -m(max=8)
alias grep='grep --color=always' # -i -n -m(max=8)
alias f='open -a Finder .'
alias ff='find . -type f -iname'
alias fd='find . -type d -iname'
alias fn='find . ! -wholename'
# login +++
SSH_HELPER=${DOTS}/ssh-helper
alias sin="LC_ALL=\"zh_CN.GBK\" luit ${SSH_HELPER}/bastion_with_cookie.exp"  # running in tmux with luit
alias sin2="export LC_ALL='zh_CN.GBK' && ${SSH_HELPER}/bastion_with_cookie.exp; export LC_ALL='en_US.UTF-8'"
alias arcsin="${SSH_HELPER}/bastion.exp"
alias cos="${SSH_HELPER}/sin.sh"
alias arccos="sh ${SSH_HELPER}/rcp_id_rsa_pub.sh"
# login ---
alias svnlog='svn log -l300 -v|more'
alias mvnp='mvn clean package -Dmaven.test.skip'
alias ptags='find . -name "*.py" -print | xargs python /usr/local/Frameworks/Python.framework/Versions/3.7/share/doc/python3.7/examples/Tools/scripts/ptags.py'
alias chrome="sh ${DOTS}/search_on_terminal.sh"
# alias cd.
#  Q: why not recursion, such as .9='.. && .8' ?
#  A: have a look at 'cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias vi='vim +'

if [ -f ${DOTS}/z/z.sh ]; then
    z_then_ls() {
        z "$1" && l
    }
    alias z='z_then_ls'
fi

# package name: osascript -e 'id of app "Finder"'
# du -d 1 | sort -nr | head -3
