# ~/zdots/sh/runtime.sh
# Language runtimes and build toolchain environment.

# LLVM
export LDFLAGS="-L$HOMEBREW_PREFIX/opt/llvm/lib"
export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/llvm/include"

# Java
# 1. Install Eclipse Temurin JDK 21 (OpenJDK 21 的一个稳定发行版本): 
# brew install --cask temurin@21
export JAVA_HOME=$(/usr/libexec/java_home -v 21 2>/dev/null || echo "")
mvn_home="/Applications/IntelliJ IDEA.app/Contents/plugins/maven/lib/maven3"

# Go
export GOPATH=/opt/gopath

# pkg-config
export PKG_CONFIG_PATH="$HOMEBREW_PREFIX/opt/openssl/lib/pkgconfig"

# Python
typeset -U pythonpath
pythonpath=(
  "$HOMEBREW_PREFIX/lib/python3.14/site-packages"
  ${(s.:.)PYTHONPATH}
)
pythonpath=(${(@)pythonpath:#})
export PYTHONPATH="${(j.:.)pythonpath}"

# PATH
path=(
  "$HOME/.local/bin"
  "$HOMEBREW_PREFIX/bin"
  "$HOMEBREW_PREFIX/sbin"
  "$HOMEBREW_PREFIX/opt/llvm/bin"
  "$JAVA_HOME/bin"
  "$mvn_home/bin"
  "$GOPATH/bin"
  /Applications/Docker.app/Contents/Resources/bin
  "$HOMEBREW_PREFIX/opt/python3/bin"
  "$HOMEBREW_PREFIX/opt/mysql-client/bin"
  $path
)
typeset -U path PATH
export PATH

unset mvn_home pythonpath
