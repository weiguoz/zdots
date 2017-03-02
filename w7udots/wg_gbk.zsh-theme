local ret_status="%(?:%{$fg_bold[green]%}>:%{$fg_bold[red]%}x%s)"
# green red white yellow grey blue

PROMPT='%F{112}%~%{$reset_color%}%F{221}$(git_prompt_info) ${ret_status}%{$reset_color%} '
# RPROMPT='%{$fg_bold[blue]%}$(git_prompt_info) %{$fg_bold[blue]%}%{$reset_color%}%B%F{039}%t%{$reset_color%}'
RPROMPT='%{$reset_color%}$(git_prompt_short_sha) %B%F{039}%t%{$reset_color%}'
# RPROMPT='%{$fg_bold[blue]%}$(git_prompt_info) $(git_prompt_short_sha) %{$fg_bold[blue]%}%{$reset_color%}%B%F{039}%t%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[white]%}(%{$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[white]%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} x"
ZSH_THEME_GIT_PROMPT_CLEAN=""
