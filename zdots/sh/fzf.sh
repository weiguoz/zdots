# git log show with fzf
#
# https://gist.github.com/tamphh/3c9a4aa07ef21232624bacb4b3f3c580/edit
# https://asciinema.org/a/257939

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
  local gitlog=(
    git log
    --graph --color=always
    --abbrev=7
    --format='%C(auto)%h %an %C(blue)%s %C(yellow)%cr'
    $@
  )

  # fzf command
  local fzf=(
    fzf
    --ansi --no-sort --reverse --tiebreak=index
    --preview "f() { set -- \$(echo -- \$@ | grep -o '[a-f0-9]\{7\}'); [ \$# -eq 0 ] || git show --color=always \$1 $filter; }; f {}"
    --bind "ctrl-q:abort,ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % $filter | less -R') << 'FZF-EOF'
                {}
                FZF-EOF"
   --preview-window=right:64% \
       --height 89%
  )

  # piping them
  $gitlog | $fzf
}

fz() {
	RG_PREFIX="rga --ignore-case --files-with-matches"
	local file
    # file="$(rga --max-count=1 --ignore-case --files-with-matches --no-messages "$*" | fzf-tmux +m --preview="rga --ignore-case --pretty --context 10 '"$*"' {}")" && open "$file" || return 1;
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --ignore-case --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
}

## Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='@@'
## Options to fzf command
export FZF_COMPLETION_OPTS='+c -x'
## fzf examples: https://github.com/junegunn/fzf/wiki/examples
export FZF_DEFAULT_OPTS='--height 40% --layout reverse --bind ctrl-f:page-down,ctrl-b:page-up' # --border
export FZF_CTRL_T_OPTS='--preview "(highlight -O ansi -l {} 2> /dev/null || bat {} --color=always --theme=Dracula --style=numbers,changes --italic-text=always || tree -C {}) 2> /dev/null | head -200"'
export FZF_DEFAULT_COMMAND='fd -I --type f --follow --hidden --exclude .git --exclude node_modules'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
