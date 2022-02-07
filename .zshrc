# {{{ this file is not clean due to
# https://www.reddit.com/r/zsh/comments/qinb6j/httpsgithubcomzdharma_has_suddenly_disappeared_i/
#
# Added by Zinit's installer
#
# How to install: https://github.com/zdharma-continuum/zinit#manual-installation
#

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit"
source "${ZINIT_HOME}/zinit.git/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

## Load a few important annexes, without Turbo
## (this is currently required for annexes)
#zinit light-mode for \
#    zinit-zsh/z-a-rust \
#    zinit-zsh/z-a-as-monitor \
#    zinit-zsh/z-a-patch-dl \
#    zinit-zsh/z-a-bin-gem-node
## End of Zinit's installer chunk }}}
## Copied from:
## https://zhuanlan.zhihu.com/p/98450570
## refers to
## https://github.com/Aloxaf/dotfiles/blob/master/zsh/.config/zsh/zshrc.zsh

zinit ice lucid wait='0'
zinit light skywind3000/z.lua
zinit ice lucid wait='0' atinit='zpcompinit'
zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice lucid wait="0" atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions
## https://github.com/Aloxaf/fzf-tab#configure
zinit light Aloxaf/fzf-tab
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# https://superuser.com/a/1092328 cd case-insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

# Since the plugin(jeffreytse/zsh-vi-mode) will overwrite the previous key bindings,
# this causes the key bindings of other plugins ( such as fzf ) to fail.
# zinit ice depth=1
# zinit light jeffreytse/zsh-vi-mode
# tasted not so good.

# {{{ 加载补全
zinit ice mv="*.zsh -> _fzf" as="completion"
zinit light junegunn/fzf # so as to snippet key-bindings.zsh
zinit snippet "$ZINIT_HOME/plugins/junegunn---fzf/shell/completion.zsh"
zinit snippet "$ZINIT_HOME/plugins/junegunn---fzf/shell/key-bindings.zsh"
zinit ice lucid wait='0'
zinit light zsh-users/zsh-completions
# }}}

# {{{ w7u, preview configuration for ohmyzsh
source ${HOME}/zdots/sh/entrance.sh
limit coredumpsize 0
setopt AUTO_LIST
setopt AUTO_MENU
# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS

# https://unix.stackexchange.com/a/37182
setopt autocd

# specify the ruby version https://github.com/rbenv/rbenv/issues/939#issuecomment-253940228
# eval "$(rbenv init -)"
# }}}

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
