#
# Configuration of the prompt
#

green="\[\033[0;32m\]"
boldgreen="\[\033[1;32m\]"
yellow="\[\033[0;33m\]"
cyan="\[\033[0;36m\]"
boldcyan="\[\033[1;36m\]"
nocolor="\[\033[0m\]"

git_branch_name() {
    local branch_name=$(git symbolic-ref -q --short HEAD 2>/dev/null)

    # check if we are in detached HEAD state
    if [ -z "$branch_name" ]; then
        local short_rev=$(git rev-parse --short HEAD 2>/dev/null)
        if [ -n "$short_rev" ]; then
            branch_name="HEAD-$short_rev"
        fi
    fi

    if [ -n "$branch_name" ]; then
        local changed_files=$(git diff --name-status | grep -v ^U | wc -l) # ignoring unmerged entries
        local delta="Δ"

        local info_string=" ($branch_name"

        if [ "$changed_files" -ne "0" ]; then
            info_string="$info_string|$delta $changed_files"
        fi

        info_string="$info_string)"

        echo "$info_string"
    fi
}

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1="${debian_chroot:+($debian_chroot)}${boldgreen}\u${nocolor}: ${cyan}\w${yellow}\$(git_branch_name)${nocolor}\n\$ "
else
    PS1="${debian_chroot:+($debian_chroot)}\u: \w\$(git_branch_name)\n\$ "
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

unset green boldgreen yellow cyan boldcyan nocolor
