## git
###  export GIT_PS1_SHOWDIRTYSTATE=true
###  export GIT_PS1_SHOWUNTRACKEDFILES=true

## LC
###  export CLICOLOR=1
###  # export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
###  export GREP_OPTIONS='--color=auto --exclude-dir=.svn'
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
iPATH=$iPATH:/usr/local/opt/go@1.13/bin

## python
iPATH=$iPATH:/usr/local/opt/python@3.9/bin

## ruby
### iPATH=/usr/local/opt/ruby/bin:$iPATH

### export DYLD_LIBRARY_PATH=$MYSQL_HOME/lib:$DYLD_LIBRARY_PATH
### export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/usr/local/Cellar/openssl/1.0.2s/include
### export C_INCLUDE_PATH=$C_INCLUDE_PATH:/usr/local/Cellar/openssl/1.0.2s/include
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

export -U PATH=$PATH:$iPATH # avoiding duplicates export caused by tmux
PROMPT_COMMAND='echo -ne "\033]0; `basename $PWD`\007"'

## fzf
### Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'
### Options to fzf command
export FZF_COMPLETION_OPTS='+c -x'
### fzf examples: https://github.com/junegunn/fzf/wiki/examples
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
