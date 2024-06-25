# https://www.reddit.com/r/zsh/comments/qinb6j/httpsgithubcomzdharma_has_suddenly_disappeared_i/
#
# Added by Zinit's installer
#
# How to install: https://github.com/zdharma-continuum/zinit#manual-installation
#
## Copied from:
## https://zhuanlan.zhihu.com/p/98450570
## refers to
## https://github.com/Aloxaf/dotfiles/blob/master/zsh/.config/zsh/zshrc.zsh
# {{{ HISTORY settings. 放在 .zshenv 中不生效，不知在哪里被覆盖了。
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
export HISTFILE=~/.zsh_history
export SAVEHIST=20000 # save history after logout
export HISTSIZE=40000 # set history size
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY #add timestamp for each entry
# }}}

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit"
skip_global_compinit="1"
source "${ZINIT_HOME}/zinit.git/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust \
    Aloxaf/fzf-tab \
    junegunn/fzf \
    b4b4r07/enhancd \
    atinit"zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions

# Turbo-enabled CompDefs
autoload -Uz compinit && compinit
zinit cdreplay -q

zinit snippet "$ZINIT_HOME/plugins/b4b4r07---enhancd/init.sh"

## https://github.com/Aloxaf/fzf-tab#configure
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# https://superuser.com/a/1092328 cd case-insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --icons --group-directories-first --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# 补全
zinit ice mv="*.zsh -> _fzf" as="completion"
# need junegunn/fzf so as to snippet key-bindings.zsh
zinit snippet "$ZINIT_HOME/plugins/junegunn---fzf/shell/completion.zsh"
zinit snippet "$ZINIT_HOME/plugins/junegunn---fzf/shell/key-bindings.zsh"
zinit ice lucid wait='0'

# {{{ theme
: ${THEME:=starship}
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
        eval "$(starship init zsh)"
        ;;
esac
# }}}
