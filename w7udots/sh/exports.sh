## git
###  export GIT_PS1_SHOWDIRTYSTATE=true
###  export GIT_PS1_SHOWUNTRACKEDFILES=true

## LC
###  export CLICOLOR=1
###  # export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
###  export GREP_OPTIONS='--color=auto --exclude-dir=.git'
###  export FIGNORE='.svn:.git'
###  export LESSCHARSET='UTF-8'
###  export LC_ALL="C"
###  export LC_COLLATE="C"
###  export LC_CTYPE="C"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk/Contents/Home
export M2_HOME=/usr/local/share/maven
iPATH=$JAVA_HOME:$M2_HOME/bin
export CLASSPATH=".:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar"

export CLASSPATH=".:/usr/local/lib/antlr-4.5.3-complete.jar:$CLASSPATH"
### export CLOUDENGINE_HOME=/usr/local/share/cloudengine
### iPATH=$iPATH:$CLOUDENGINE_HOME/bin

iPATH=$iPATH:~/w7udots/bin

## go
export GOPATH=~/go
iPATH=$iPATH:$GOPATH/bin
iPATH=$iPATH:/usr/local/opt/go/bin

## only python3
iPATH=$iPATH:/usr/local/opt/python@3/bin
export PYTHONPATH="/usr/local/lib/python3.9/site-packages:$PYTHONPATH" # pip3 installed

## ruby
### iPATH=/usr/local/opt/ruby/bin:$iPATH

### export DYLD_LIBRARY_PATH=$MYSQL_HOME/lib:$DYLD_LIBRARY_PATH
### export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/usr/local/Cellar/openssl/1.0.2s/include
### export C_INCLUDE_PATH=$C_INCLUDE_PATH:/usr/local/Cellar/openssl/1.0.2s/include

export -U PATH=$PATH:$iPATH # avoiding duplicates export caused by tmux

### exa(colorful ls) color
export EXA_COLORS="${EXA_COLORS}:da=1;30" # :di=1;34:ln=1;34:"
