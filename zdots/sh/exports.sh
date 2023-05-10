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
iPATH="/opt/homebrew/bin:/opt/homebrew/sbin"

## Java
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk/Contents/Home
export JAVA_HOME=/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home # brew info java
iPATH=$iPATH:"$JAVA_HOME/bin"
export CLASSPATH=".:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar"
# export M2_HOME=/usr/local/share/maven
# iPATH=$iPATH:$M2_HOME/bin
## go
export GOPATH=/opt/go
iPATH=$iPATH:"$GOPATH/bin"

## pkgconfig
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl/lib/pkgconfig"

## only python3
iPATH=$iPATH:"/opt/homebrew/opt/python@3.11/bin" # make soft links('ln -s') python3 & pip3 from the specific version
export PYTHONPATH=`uniq_csv "/opt/homebrew/lib/python3.11/site-packages:$PYTHONPATH"`

### exa(colorful ls) color
### export CLICOLOR=1
### export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export EXA_COLORS="${EXA_COLORS}:da=1;30:di=1;36" # :ln=1;34:"

### enhancd https://github.com/b4b4r07/enhancd#using-package-manager
# export ENHANCD_FILTER='fzf --preview "exa -al --tree --level 1 --group-directories-first --git-ignore --header --git --no-user --no-time --no-filesize --no-permissions {}" --preview-window right,50% --height 35% --reverse --ansi'

export PATH=`uniq_csv "$iPATH:$PATH"` # order is important
unset iPATH
