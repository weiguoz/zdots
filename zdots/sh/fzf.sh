# git log show with fzf
#
# https://gist.github.com/tamphh/3c9a4aa07ef21232624bacb4b3f3c580
# https://asciinema.org/a/257939
## Use ~~ as the trigger sequence instead of the default **

export FZF_COMPLETION_TRIGGER='@@'
## fzf examples: https://github.com/junegunn/fzf/wiki/examples
export FZF_DEFAULT_COMMAND='fd -I --type f --type d --follow --hidden --exclude .git --exclude node_modules --max-results=827 --size=-500m'
export FZF_DEFAULT_OPTS="
  --color fg:255,bg:236,hl:84,fg+:255,bg+:236,hl+:215
  --color info:141,prompt:84,spinner:212,pointer:212,marker:212
  -m --height 80% --layout reverse --inline-info
  --bind 'ctrl-f:half-page-down,ctrl-b:half-page-up,ctrl-j:ignore,ctrl-k:ignore'" # --border
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "(bat {} --color=always || highlight -O ansi -l {} 2> /dev/null || tree -C {}) 2> /dev/null"'

# git log show with fzf.
# Replaced by: https://github.com/bigH/git-fuzzy
# gig() {
#     # param validation
#     if [[ ! `git log -n 1 "$@" | head -n 1` ]]; then
#         return
#     fi
#
#     # filter by file string
#     local filter
#     # param existed, git log for file if existed
#     if [ -n "$@" ] && [ -f "$@" ]; then
#         filter="-- $@"
#     fi
#
#     # https://devhints.io/git-log-format
#     local gitlog=(
#         git log --graph --color=always --abbrev=7 --pretty=format:"%d %Cgreen%h%Creset %ar %Cred%an%Creset %s"
#         $@
#     )
#
#     local res=(
#         fzf --ansi --no-sort --reverse --tiebreak=index \
#             --preview "localf() { set -- \$(echo -- \$@ | grep -o '[a-f0-9]\{7\}'); [ \$# -eq 0 ] || git show --color=always \$1 $filter; }; localf {}" \
#             --bind "ctrl-q:abort,ctrl-m:execute: (grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % $filter | less -R') << 'FZF-EOF' {} FZF-EOF" \
#             --preview-window=right:64% \
#             --height 89%
#     )
#     $gitlog | $res # piping them
# }

pods() {
  FZF_DEFAULT_COMMAND="kubectl get pods --all-namespaces" \
    fzf --info=inline --layout=reverse --header-lines=1 \
        --prompt "$(kubectl config current-context | sed 's/-context$//')> " \
        --header $'↩︎: [tail log]    ^-f: [logs]    ^-i: [describe]    ^-o[aboard]' \
        --bind 'enter:execute:sh -c "kubectl logs --follow --all-containers --tail=10000 --namespace {1} {2}" > /dev/tty' \
        --bind 'ctrl-f:execute:sh -c "kubectl logs --since=4h --all-containers --namespace {1} {2} | nvim - +" > /dev/tty' \
        --bind 'ctrl-i:execute:sh -c "kubectl describe pods --namespace {1} {2} | nvim" > /dev/tty' \
        --bind 'ctrl-o:execute:kubectl exec -it --namespace {1} {2} -- sh > /dev/tty' \
        --preview-window up:follow \
        --preview 'kubectl logs --follow --all-containers --tail=10000 --namespace {1} {2}' "$@"
}

# also, rg does not supply fuzzy search: https://github.com/BurntSushi/ripgrep/issues/1053
# refer: https://github.com/junegunn/fzf/blob/master/ADVANCED.md#switching-to-fzf-only-search-mode
my_fzf_rg() {
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
    # split to an array method1: local a=("${(@s/:/)selected}") && [ -f "${a[1]}" ] && vim "${a[1]}" "+${a[2]}"
    IFS=':' read -r fn le _ <<<"$selected"
    [ -f "$fn" ] && vim "$fn" "+$le"
}
