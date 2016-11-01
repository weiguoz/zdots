MY_DOTS_IN='w7udots'
# export GIT_PS1_SHOWDIRTYSTATE=true
# export GIT_PS1_SHOWUNTRACKEDFILES=true
#
# export CLICOLOR=1
# # export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
# export GREP_OPTIONS='--color=auto --exclude-dir=.svn'
# export FIGNORE='.svn:.git'
# export LESSCHARSET='UTF-8'
# # export LC_ALL="C"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# export LC_COLLATE="C"
# export LC_CTYPE="C"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk/Contents/Home
export ANT_HOME=/usr/local/share/ant
#export IVY_HOME=/usr/share/ivy
export M2_HOME=/usr/local/share/maven
#export GOPATH=${HOME}/go
# export http_proxy=localhost:1080
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

#MYSQL_HOME=/usr/local/mysql
iPATH=$JAVA_HOME:$M2_HOME/bin
iPATH=$iPATH:$ANT_HOME/bin
#iPATH=$iPATH:$MYSQL_HOME/bin
#iPATH=$iPATH:/usr/local/go/bin:$GOPATH/bin
#iPATH=$iPATH:/Applications/Postgres.app/Contents/Versions/9.5/bin
# iPATH=$iPATH:/usr/local/spring/bin

export PATH=$PATH:$iPATH
#export DYLD_LIBRARY_PATH=$MYSQL_HOME/lib:$DYLD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=/usr/local/Cellar/openssl/1.0.2j/include
export C_INCLUDE_PATH=/usr/local/Cellar/openssl/1.0.2j/include
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

#eval $(thefuck --alias)
if [ -f ~/${MY_DOTS_IN}/common.sh ]; then
    . ~/${MY_DOTS_IN}/common.sh
    import ~/${MY_DOTS_IN}/z.sh # https://github.com/rupa/z
    import ~/${MY_DOTS_IN}/alias.sh
    import ~/${MY_DOTS_IN}/functions.sh
    # import /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
fi
# export PS1='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
