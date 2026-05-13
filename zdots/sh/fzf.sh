# git log show with fzf
#
# https://gist.github.com/tamphh/3c9a4aa07ef21232624bacb4b3f3c580
# https://asciinema.org/a/257939

# Use @@ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='@@'

# fzf examples: https://github.com/junegunn/fzf/wiki/examples

# Default source for bare `fzf` and Ctrl-T.
export FZF_DEFAULT_COMMAND='fd -I --type f --type d --follow --hidden --exclude .git --exclude node_modules --max-results=827 --size=-500m'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Global fzf defaults.
#
# Keep this list generic:
# - layout / style / colors
# - safe key bindings
#
# Do not put file-specific preview commands here, because fzf is also used for
# history, grep results, kubectl output, process lists, etc.
export FZF_DEFAULT_OPTS="
  --multi
  --height=45%
  --layout=reverse
  --border=rounded
  --margin=1
  --padding=1
  --info=inline
  --prompt='❯ '
  --pointer='▶'
  --marker='✓'
  --separator='─'
  --scrollbar='│'
  --bind='ctrl-f:page-down,ctrl-b:page-up'
  --bind='ctrl-u:preview-page-up,ctrl-d:preview-page-down'
  --color=fg:#d0d0d0,bg:#1e1e2e,hl:#f9e2af
  --color=fg+:#ffffff,bg+:#313244,hl+:#fab387
  --color=info:#89b4fa,prompt:#f38ba8,pointer:#f5c2e7
  --color=marker:#a6e3a1,spinner:#f9e2af,header:#94e2d5
  --color=border:#89b4fa,separator:#45475a,scrollbar:#585b70
"

# Ctrl-T is file/directory oriented, so preview is safe here.
export FZF_CTRL_T_OPTS="
  --preview='(bat {} --color=always || highlight -O ansi -l {} 2>/dev/null || tree -C {}) 2>/dev/null'
"

# Ctrl-R history search.
export FZF_CTRL_R_OPTS="
  --height=55%
  --border-label=' History '
  --prompt='Match ❯ '
  --preview='echo {}'
  --preview-window=down:4:wrap
  --bind='ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --header='CTRL-R: search history | ENTER: use | CTRL-Y: copy command'
"

pods() {
  FZF_DEFAULT_COMMAND="kubectl get pods --all-namespaces" \
    fzf --header-lines=1 \
    --prompt "$(kubectl config current-context | sed 's/-context$//')> " \
    --header $'↩︎: [describe] ^-o[aboard] ^-f: [logs] ^-t: [tail log]' \
    --bind 'enter:execute:sh -c "kubectl describe pods --namespace {1} {2} | nvim" > /dev/tty' \
    --bind 'ctrl-o:execute:kubectl exec -it --namespace {1} {2} -- sh > /dev/tty' \
    --bind 'ctrl-f:execute:sh -c "kubectl logs --since=4h --all-containers --namespace {1} {2} | nvim - +" > /dev/tty' \
    --bind 'ctrl-t:execute:sh -c "kubectl logs --follow --all-containers --tail=10000 --namespace {1} {2}" > /dev/tty' \
    --preview-window up:follow \
    --preview 'kubectl logs --follow --all-containers --tail=10000 --namespace {1} {2}' "$@"
}

# also, rg does not supply fuzzy search: https://github.com/BurntSushi/ripgrep/issues/1053
# refer: https://github.com/junegunn/fzf/blob/master/ADVANCED.md#switching-to-fzf-only-search-mode
_my_fzf_rg() {
  INITIAL_QUERY="${*:-}"
  RG_PREFIX='rg --column --line-number --hidden --multiline --no-heading --color=always --smart-case --colors "path:fg:190,220,255" --colors "line:fg:128,128,128"'

  local selected=$(
    fzf --ansi --sort --phony --disabled --query "$INITIAL_QUERY" \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
      --bind "ctrl-l:unbind(change,ctrl-l)+change-prompt(2. fzf> )+enable-search+clear-query+rebind(ctrl-o)" \
      --bind "ctrl-o:unbind(ctrl-o)+change-prompt(1. rg> )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-l)" \
      --prompt '1. rg> ' \
      --delimiter : \
      --header 'ctrl-o (rg mode, precision content) | ctrl-l (fzf mode, fuzzy title)' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~2' \
      --preview="[[ ! -z {1} ]] && (([[ -z {2} ]] && bat --color=always {1}) || bat --color=always {1} -H {2} --theme='Dracula')"
  )

  # split to an array method1:
  # local a=("${(@s/:/)selected}") && [ -f "${a[1]}" ] && vim "${a[1]}" "+${a[2]}"

  IFS=':' read -r fn le _ <<<"$selected"
  [ -f "$fn" ] && vim "$fn" "+$le"
}
