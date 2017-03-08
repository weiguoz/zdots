# sourced by ~/.bashrc normally
alias v='vim'
alias vi='vim'
alias vm='vim'
alias md5sum='md5 -r'
alias md5='md5 -r'
alias ls='ls -pFGh'
alias l='ls -l'
alias ll='ls -al'
alias la='ls -a'
alias woman='man'
alias kuai='man'
alias hist='history'
alias grep='grep -i --color'
alias f='open -a Finder .'
alias ff='find . -type f -iname'
alias fd='find . -type d -iname'
alias fn='find . ! -wholename'
alias sin='~/w7udots/ssh-helper/sin.sh'
alias rsa_spawn='sh ~/w7udots/rcp_id_rsa_pub.sh'
# alias rsin='export LC_ALL="zh_CN.GBK" && ~/w7udots/ssh-helper/bastion.exp; export LC_ALL="en_US.UTF-8"'
alias sshgbk='/usr/local/bin/luit -encoding gbk ssh'
alias rsin='~/w7udots/ssh-helper/bastion.exp'
alias svnlog='svn log -l30 -v|more'
# alias cd
alias ..='cd ..'
alias ...='cd ../..'
alias .2='... && l'
alias .3='cd ../../.. && l'
alias .4='cd ../../../.. && l'
alias .5='cd ../../../../.. && l'
alias .6='cd ../../../../../.. && l'
alias .7='cd ../../../../../../.. && l'
cs() {
    builtin cd "$1" && l
}
# alias cs='cdls'

if [ -f /Users/weiguo/w7udots/z.sh ]; then
    zls() {
        z "$1" && l
    }
    alias zs='zls'
fi

# du -d 1 | sort -nr | head -3
