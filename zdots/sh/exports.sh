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
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk/Contents/Home
export JAVA_HOME=/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home # brew info java
iPATH=$JAVA_HOME/bin
export CLASSPATH=".:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar"
# export M2_HOME=/usr/local/share/maven
# iPATH=$iPATH:$M2_HOME/bin
## go
export GOPATH=/opt/go
iPATH=$iPATH:$GOPATH/bin
## homebrew
iPATH=$iPATH:/opt/homebrew/bin

## only python3
### iPATH=$iPATH:/opt/homebrew/opt/python@3.10/bin # make a soft link('ln -s') from /opt/homebrew/Cellar/python@3.10/3.10.0_1
export PYTHONPATH=`uniq_csv "/opt/homebrew/lib/python3.9/site-packages:$PYTHONPATH"`

### exa(colorful ls) color
### export CLICOLOR=1
### export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export EXA_COLORS="${EXA_COLORS}:da=1;30:di=1;36" # :ln=1;34:"

export PATH=`uniq_csv "$iPATH:$PATH"` # order is important
