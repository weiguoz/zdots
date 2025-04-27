#!/bin/sh

## git
### export GIT_PS1_SHOWDIRTYSTATE=true
### export GIT_PS1_SHOWUNTRACKEDFILES=true

## LC
### export GREP_OPTIONS='--color=auto --exclude-dir=.git'
### export FIGNORE='.svn:.git'
### export LESSCHARSET='UTF-8'
### export LC_ALL="C"
### export LC_COLLATE="C"
### export LC_CTYPE="C"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
## homebrew
local BREWHOME="/opt/homebrew"
local iPATH="$BREWHOME/bin:$BREWHOME/sbin"

## llvm
iPATH=$iPATH:"$BREWHOME/opt/llvm/bin"
export LDFLAGS="-L$BREWHOME/opt/llvm/lib"
export CPPFLAGS="-I$BREWHOME/opt/llvm/include" # or /c++/v1 ?

## Java
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk/Contents/Home
export JAVA_HOME=$BREWHOME/opt/openjdk/libexec/openjdk.jdk/Contents/Home # brew info java
iPATH=$iPATH:"$JAVA_HOME/bin"
export CLASSPATH=".:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar"
# export M2_HOME=/usr/local/share/maven
# iPATH=$iPATH:$M2_HOME/bin
## go
export GOPATH=/opt/gopath
iPATH=$iPATH:"$GOPATH/bin"

## pkgconfig
export PKG_CONFIG_PATH="$BREWHOME/opt/openssl/lib/pkgconfig"

## docker
iPATH=$iPATH:"/Applications/Docker.app/Contents/Resources/bin"

## python3: required by glances, icdiff, pre-commit, ranger and virtualenv
iPATH=$iPATH:"$BREWHOME/opt/python3/bin" # make soft links('ln -s') python3 & pip3 from the specific version
export PYTHONPATH=`uniq_csv "$BREWHOME/lib/python3.13/site-packages:$PYTHONPATH"`

# {{{ mysql-client
iPATH=$iPATH:"$BREWHOME/opt/mysql-client/bin"
#For compilers to find mysql-client you may need to set:
#  export LDFLAGS="-L/opt/homebrew/opt/mysql-client/lib"
#  export CPPFLAGS="-I/opt/homebrew/opt/mysql-client/include"
#
#For pkg-config to find mysql-client you may need to set:
#  export PKG_CONFIG_PATH="/opt/homebrew/opt/mysql-client/lib/pkgconfig"
# }}}

### exa(colorful ls) color
### export CLICOLOR=1
### export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
# export EZA_COLORS="${EZA_COLORS}:da=1;30:di=1;36" # :ln=1;34:" # good for macOS.terminal, but not good for ghostty, so it's commented out

### enhancd https://github.com/b4b4r07/enhancd#using-package-manager
export ENHANCD_FILTER='fzf --preview "eza -al --tree --level 1 --group-directories-first --git-ignore --header --git --no-user --no-time --no-filesize --no-permissions {}" --preview-window right,50% --height 35% --reverse --ansi'

export PATH=`uniq_csv "$iPATH:$PATH"` # order is important
# unset BREWHOME
