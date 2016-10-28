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
alias grep='grep --color'
alias f='open -a Finder .'
alias ff='find . -type f -iname'
alias fd='find . -type d -iname'
alias fn='find . ! -wholename'
alias scp='scp -P10022'
alias sin='~/w7udots/sin.sh'
alias rsin='~/w7udots/rsin.sh'
alias rlog='~/w7udots/bastion_log.exp'
alias py3='python3'
# alias cd
alias ..='cd ..'
alias ...='cd ../..'
alias .2='.. && l'
alias .3='... && l'
alias .4='cd ../../.. && l'
alias .5='cd ../../../.. && l'
alias .6='cd ../../../../.. && l'
cs() {
    builtin cd "$1" && l
}
# alias cs='cdls'

if [ -f /Users/weiguo/w7udots/z.sh ]; then
    zls() {
        z "$1" && l
    }
    alias s='zls'
fi

# du -d 1 | sort -nr | head -3
