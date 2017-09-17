# sourced by ~/.bashrc normally
# just4fun
alias woman='man'
# here we go
alias v='vim'
alias vi='vim'
alias vm='vim'
alias md5sum='md5 -r'
alias md5='md5 -r'
alias t='tmux'
alias ls='ls -pFGh'
alias l='ls -l'
alias ll='ls -al'
alias la='ls -a'
alias hist='history'
alias grep='grep -i --color'
alias g='grep'
alias pg='ps -ef | grep -v grep | grep'
alias has='xargs grep -Hli' # xargs grep -i "$1" | awk -F':' '{print $1}' | sort -u
alias sah='xargs grep -HLi'
alias f='open -a Finder .'
alias ff='find . -type f -iname'
alias fd='find . -type d -iname'
alias fn='find . ! -wholename'
alias sin='~/w7udots/ssh-helper/sin.sh'
alias rsa_spawn='sh ~/w7udots/rcp_id_rsa_pub.sh'
alias rsin0='export LC_ALL="zh_CN.GBK" && ~/w7udots/ssh-helper/bastion.exp; export LC_ALL="en_US.UTF-8"'
alias rsin='export LC_ALL="zh_CN.GBK" && ~/w7udots/ssh-helper/bastion_with_cookie.exp; export LC_ALL="en_US.UTF-8"'
alias svnlog='svn log -l30 -v|more'
alias mvni='mvn clean install -Dmaven.test.skip'
alias mvnd='mvn clean deploy -Dmaven.test.skip'
alias mvnp='mvn clean package -Dmaven.test.skip'
# alias cd
alias ..='cd ..'
alias ...='cd ../..'
alias .2='... && l'
alias .3='cd ../../.. && l'
alias .4='cd ../../../.. && l'
alias .5='cd ../../../../.. && l'
alias .6='cd ../../../../../.. && l'
alias .7='cd ../../../../../../.. && l'
alias .8='cd ../../../../../../../.. && l'
alias .9='cd ../../../../../../../../.. && l'
cs() {
    builtin cd "$1" && l
}
# alias cs='cdls'

if [ -f ~/w7udots/z.sh ]; then
    z_then_ls() {
        z "$1" && l
    }
    alias go='z_then_ls'
fi

# package name: osascript -e 'id of app "Finder"'
# du -d 1 | sort -nr | head -3
