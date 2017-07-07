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
export CLOUDENGINE_HOME=/usr/local/share/cloudengine
#export GOPATH=${HOME}/go
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

#MYSQL_HOME=/usr/local/mysql
iPATH=$JAVA_HOME:$M2_HOME/bin
iPATH=$iPATH:$ANT_HOME/bin
iPATH=$iPATH:$CLOUDENGINE_HOME/bin
#iPATH=$iPATH:$MYSQL_HOME/bin
#iPATH=$iPATH:/usr/local/go/bin:$GOPATH/bin
#iPATH=$iPATH:/Applications/Postgres.app/Contents/Versions/9.5/bin
# iPATH=$iPATH:/usr/local/spring/bin

#export DYLD_LIBRARY_PATH=$MYSQL_HOME/lib:$DYLD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=/usr/local/Cellar/openssl/1.0.2j/include
export C_INCLUDE_PATH=/usr/local/Cellar/openssl/1.0.2j/include
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

function setproxy() {
    # export {HTTP,HTTPS,FTP}_PROXY="http://127.0.0.1:3128" 也可以设置http代理
    export ALL_PROXY=socks5://127.0.0.1:1086
}

function unsetproxy() {
    # unset {HTTP,HTTPS,FTP}_PROXY
    unset ALL_PROXY
}
export PATH=$PATH:$iPATH
