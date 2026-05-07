# ~/.zshenv
# Loaded by every zsh process. Keep it minimal.

export DOTS="${DOTS:-$HOME/zdots}"

if [[ -z "$HOMEBREW_PREFIX" ]]; then
  if [[ -x /opt/homebrew/bin/brew ]]; then
    HOMEBREW_PREFIX=$(/opt/homebrew/bin/brew --prefix)
  elif [[ -x /usr/local/bin/brew ]]; then
    HOMEBREW_PREFIX=$(/usr/local/bin/brew --prefix)
  fi
fi

path=(
  "$HOMEBREW_PREFIX/bin"
  "$HOMEBREW_PREFIX/sbin"
  /usr/local/bin
  /System/Cryptexes/App/usr/bin
  /usr/bin
  /bin
  /usr/sbin
  /sbin
  $path
)

typeset -U path PATH
export PATH
