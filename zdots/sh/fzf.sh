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
#export FZF_DEFAULT_OPTS='-m --height 80% --layout reverse --inline-info --bind ctrl-f:page-down,ctrl-b:page-up' # --border
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "(highlight -O ansi -l {} 2> /dev/null || bat {} --color=always --theme=Dracula --style=numbers,changes --italic-text=always || tree -C {}) 2> /dev/null"'

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

  # git command
  # https://devhints.io/git-log-format
  local gitlog=(
    git log --graph --color=always --abbrev=7 --pretty=format:"%d %Cgreen%h%Creset %ar %Cred%an%Creset %s"
    $@
  )

  # fzf command
  local res=(
    fzf --ansi --no-sort --reverse --tiebreak=index \
        --preview "f() { set -- \$(echo -- \$@ | grep -o '[a-f0-9]\{7\}'); [ \$# -eq 0 ] || git show --color=always \$1 $filter; }; f {}" \
        --bind "ctrl-q:abort,ctrl-m:execute: (grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % $filter | less -R') << 'FZF-EOF' {} FZF-EOF" \
        --preview-window=right:64% \
        --height 89%
  )

  # piping them
  $gitlog | $res
}

# also, rg does not supply fuzzy search: https://github.com/BurntSushi/ripgrep/issues/1053
my_fzf_rg() {
	command_base="rg --smart-case --multiline"
	command_fmt="${command_base} --files-with-matches --no-ignore" # --no-ignore: all files as `fd -I` does
    local res="$(
		FZF_DEFAULT_COMMAND="$command_fmt '$1'" \
            fzf --sort --preview="[[ ! -z {} ]] && ${command_base} --pretty --context 10 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$command_fmt {q}" \
				--preview-window="80%:wrap"
	)" && \
        if [ -f "$res" ]; then
            vim "$res"
        fi
}
