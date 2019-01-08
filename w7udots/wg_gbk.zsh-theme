local ret_status="%(?:%{$fg_bold[green]%}$:%{$fg_bold[red]%}x%s)"
# green red white yellow grey blue

# ########## GIT ###########
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[white]%}(%{$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[white]%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} x"
ZSH_THEME_GIT_PROMPT_CLEAN=""
# ########## SVN ###########
# ZSH_THEME_SVN_PROMPT_PREFIX="${PR_RESET}${PR_RED} svn:"
# ZSH_THEME_SVN_PROMPT_SUFFIX=""
# ZSH_THEME_SVN_PROMPT_DIRTY="${VCS_DIRTY_COLOR}${VCS_SUFIX_COLOR}"
# ZSH_THEME_SVN_PROMPT_CLEAN="${VCS_CLEAN_COLOR}${VCS_SUFIX_COLOR}"

PROMPT='
%F{112}%~%{$reset_color%} %F{221}$(git_prompt_info) $(git_prompt_short_sha)
${ret_status}%{$reset_color%} '
# with svn PROMPT='%F{112}%~%{$reset_color%}%F{221}$(git_prompt_info)$(svn_prompt_info) ${ret_status}%{$reset_color%} '
RPROMPT='%{$reset_color%} %B%F{039}%t%{$reset_color%}'
# RPROMPT='%{$fg_bold[blue]%}$(git_prompt_info) %{$fg_bold[blue]%}%{$reset_color%}%B%F{039}%t%{$reset_color%}'
# RPROMPT='%{$fg_bold[blue]%}$(git_prompt_info) $(git_prompt_short_sha) %{$fg_bold[blue]%}%{$reset_color%}%B%F{039}%t%{$reset_color%}'
