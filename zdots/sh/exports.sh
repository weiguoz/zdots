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

## Java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk/Contents/Home
export CLASSPATH=".:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar"
export M2_HOME=/usr/local/share/maven
iPATH=$JAVA_HOME/bin:$M2_HOME/bin
## go
export GOPATH=/opt/go
iPATH=$iPATH:$GOPATH/bin
## homebrew
iPATH=$iPATH:/opt/homebrew/bin
export PATH=`uniq_csv "$iPATH:$PATH"` # order is important

## only python3
export PYTHONPATH=`uniq_csv "/opt/homebrew/lib/python3.9/site-packages:$PYTHONPATH"`

### exa(colorful ls) color
### export CLICOLOR=1
### export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export EXA_COLORS="${EXA_COLORS}:da=1;30:di=1;36" # :ln=1;34:"
