local current_user="%{$fg_bold[green]%}%n%{$reset_color%}"

local current_dir="%{$fg[cyan]%}%~%{$reset_color%}"

local ret_status="%(?:%{$fg_bold[cyan]%}:%{$fg_bold[red]%})"
local command_sign="${ret_status}➜ %{$reset_color%}"

PROMPT='${current_user}: ${current_dir} $(git_prompt_info)
${command_sign}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[yellow]%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
