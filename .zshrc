# ~/.zshrc

[[ -o interactive ]] || return
source "$DOTS/sh/_.sh"

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit"
skip_global_compinit="1"
source "${ZINIT_HOME}/zinit.git/zinit.zsh"

# 必须同步加载
zinit light-mode for \
    zsh-users/zsh-autosuggestions

zinit wait lucid for \
    Aloxaf/fzf-tab \
    b4b4r07/enhancd \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust \
    zdharma-continuum/fast-syntax-highlighting \
    atinit"zicompinit; zicdreplay" \
    atpull'zinit creinstall -q .' zsh-users/zsh-completions

# 补全脚本，否则 bat 等的 tab 不 work
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(
  "$HOME/.docker/completions"
  $HOMEBREW_PREFIX/share/zsh/site-functions
  $fpath
)

autoload -Uz compinit
compinit -C
# End of Docker CLI completions

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# 如果是 'm:{a-zA-Z}={A-Za-z}'，则 ls/vim 等操作不自动补全。比如某文件只有e f 两个文本文件
# 这里 follow vim 的按键方案，不区分大小写，然而当输入大写字母，则为大小写敏感了
# https://superuser.com/a/1092328 cd case-insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 限定 ssh 主机补全
zstyle ':completion:*:ssh:*' hosts $(awk '/^Host / {print $2}' ~/.ssh/config)
zstyle ':completion:*:*:ssh:*' tag-order 'hosts'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-f:page-down' 'ctrl-b:page-up' 'ctrl-j:ignore' 'ctrl-k:ignore' # FZF_DEFAULT_OPTS not works for fzf-tab

# 补全
# zinit ice mv="*.zsh -> _fzf" as="completion"
# need junegunn/fzf so as to snippet key-bindings.zsh
# zinit snippet "$ZINIT_HOME/plugins/junegunn---fzf/shell/completion.zsh"
# zinit snippet "$ZINIT_HOME/plugins/junegunn---fzf/shell/key-bindings.zsh"

# https://github.com/bigH/git-fuzzy
zinit ice as"program" pick"bin/git-fuzzy"
zinit light bigH/git-fuzzy
export GF_HORIZONTAL_PREVIEW_PERCENT_CALCULATION='max(50, min(80, 100 - (7000 / __WIDTH__)))'

# {{{ theme
: ${THEME:=p10k}
case $THEME in
    pure)
        PROMPT=$'\n%F{cyan}❯ %f'
        RPROMPT=""
        zstyle ':prompt:pure:prompt:success' color cyan
        zinit ice lucid wait="!0" pick="async.zsh" src="pure.zsh" atload="prompt_pure_precmd"
        zinit light Aloxaf/pure
        ;;
    p10k)
        zinit ice depth=1
        zinit light romkatv/powerlevel10k
        # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
        # Initialization code that may require console input (password prompts, [y/n]
        # confirmations, etc.) must go above this block; everything else may go below.
        if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
          source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
        fi
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
        ;;
    starship)
        if command -v starship >/dev/null 2>&1; then
          eval "$(starship init zsh)"
        fi
        ;;
esac
# }}}

# automatic added by vim plugin fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi
