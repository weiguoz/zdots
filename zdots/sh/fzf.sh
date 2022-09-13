# git log show with fzf
#
# https://gist.github.com/tamphh/3c9a4aa07ef21232624bacb4b3f3c580
# https://asciinema.org/a/257939
## Use ~~ as the trigger sequence instead of the default **

export FZF_COMPLETION_TRIGGER='@@'
## fzf examples: https://github.com/junegunn/fzf/wiki/examples
export FZF_DEFAULT_COMMAND='fd -I --type f --follow --hidden --exclude .git --exclude node_modules'
export FZF_DEFAULT_OPTS='
  --color fg:255,bg:236,hl:84,fg+:255,bg+:236,hl+:215
  --color info:141,prompt:84,spinner:212,pointer:212,marker:212
  -m --height 80% --layout reverse --inline-info --bind ctrl-f:page-down,ctrl-b:page-up' # --border
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "(bat {} --color=always --theme=Dracula --style=numbers,changes --italic-text=always || highlight -O ansi -l {} 2> /dev/null || tree -C {}) 2> /dev/null"'

# git log show with fzf
gig() {
    # param validation
    if [[ ! `git log -n 1 "$@" | head -n 1` ]]; then
        return
    fi

    # filter by file string
    local filter
    # param existed, git log for file if existed
    if [ -n "$@" ] && [ -f "$@" ]; then
        filter="-- $@"
    fi

    # https://devhints.io/git-log-format
    local gitlog=(
        git log --graph --color=always --abbrev=7 --pretty=format:"%d %Cgreen%h%Creset %ar %Cred%an%Creset %s"
        $@
    )

    local res=(
        fzf --ansi --no-sort --reverse --tiebreak=index \
            --preview "f() { set -- \$(echo -- \$@ | grep -o '[a-f0-9]\{7\}'); [ \$# -eq 0 ] || git show --color=always \$1 $filter; }; f {}" \
            --bind "ctrl-q:abort,ctrl-m:execute: (grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % $filter | less -R') << 'FZF-EOF' {} FZF-EOF" \
            --preview-window=right:64% \
            --height 89%
    )
    $gitlog | $res # piping them
}

# also, rg does not supply fuzzy search: https://github.com/BurntSushi/ripgrep/issues/1053
my_fzf_rg() {
	rgcmd='rg --smart-case --multiline --colors "path:fg:190,220,255" --colors "line:fg:128,128,128"'
    local res=$(
        fzf --sort --preview="[[ ! -z {} ]] && ${rgcmd} --pretty --context 9 --field-context-separator '  ' --field-match-separator '  ' {q} {}" \
			--phony -q "$1" \
			--bind "change:reload:${rgcmd} --files-with-matches --no-ignore {q}" \
			--preview-window="80%:wrap"
	) && [ -f "$res" ] && vim "$res"
}
