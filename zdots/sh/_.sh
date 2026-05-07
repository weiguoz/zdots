# Main interactive zsh entrypoint.

[[ -o interactive ]] || return

: "${DOTS:=$HOME/zdots}" # defined in .zshenv

limit coredumpsize 0 2>/dev/null || true
setopt auto_list
setopt auto_menu
setopt autocd

_import() {
  local file="$1"
  [[ -n "$file" && -f "$file" ]] && source "$file"
}

# 1. Base helpers first.
_import "$DOTS/sh/functions.sh"

# 2. Environment, PATH, and runtimes.
_import "$DOTS/sh/init_env.sh"
_import "$DOTS/sh/runtime.sh"

# 3. Shell behavior.
_import "$DOTS/sh/history.sh"
_import "$DOTS/sh/keybinding.sh"
_import "$DOTS/sh/search_on_terminal.sh"

# 4. Aliases and command integrations.
_import "$DOTS/sh/alias.sh"
_import "$DOTS/sh/fzf.sh"
_import "$DOTS/sh/enhancd.sh"
_import "$DOTS/sh/proxy.sh"

# 5. Local/private files.
_import "$HOME/Documents/secrets/sh/_.sh"
_import "$HOME/.local/bin/env"

unset -f _import
