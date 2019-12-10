# export GIT_PS1_SHOWDIRTYSTATE=true
# export GIT_PS1_SHOWUNTRACKEDFILES=true
#
# export CLICOLOR=1
# # export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
# export GREP_OPTIONS='--color=auto --exclude-dir=.svn'
# export FIGNORE='.svn:.git'
# export LESSCHARSET='UTF-8'
# export LC_ALL="C"
# export LC_COLLATE="C"
# export LC_CTYPE="C"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk/Contents/Home
export ANT_HOME=/usr/local/share/ant
# export IVY_HOME=/usr/share/ivy
export M2_HOME=/usr/local/share/maven
export CLOUDENGINE_HOME=/usr/local/share/cloudengine
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

# MYSQL_HOME=/usr/local/mysql
iPATH=$JAVA_HOME:$M2_HOME/bin
iPATH=$iPATH:$ANT_HOME/bin
iPATH=$iPATH:$CLOUDENGINE_HOME/bin
iPATH=$iPATH:~/w7udots/bin
# iPATH=$iPATH:$MYSQL_HOME/bin
# go
export GOPATH=~/go
iPATH=$iPATH:$GOPATH/bin
# iPATH=$iPATH:/Applications/Postgres.app/Contents/Versions/9.5/bin
# iPATH=$iPATH:/usr/local/spring/bin
# ruby
iPATH=/usr/local/opt/ruby/bin:$iPATH

# export DYLD_LIBRARY_PATH=$MYSQL_HOME/lib:$DYLD_LIBRARY_PATH
# add include dir to c(pp)_includes
# export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/usr/local/Cellar/openssl/1.0.2s/include
# export C_INCLUDE_PATH=$C_INCLUDE_PATH:/usr/local/Cellar/openssl/1.0.2s/include
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

export -U PATH=$PATH:$iPATH # avoiding duplicates export caused by tmux
PROMPT_COMMAND='echo -ne "\033]0; `basename $PWD`\007"'
## fzf +++
# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'
# Options to fzf command
export FZF_COMPLETION_OPTS='+c -x'
# fzf examples: https://github.com/junegunn/fzf/wiki/examples
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
## fzf ---
