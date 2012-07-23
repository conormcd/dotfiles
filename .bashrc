# It's tempting to make this 077, but then installing stuff with sudo can
# result in the undesirable effect of programs privately owned by root.
umask 022

# PROMPT_COMMAND is appended to so reset it to avoid making it huge if this
# file is sourced multiple times.
PROMPT_COMMAND=""

# Make sure the path covers everything
PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin"
typeset -a potential_extra_dirs=( \
    /opt/local/sbin \
    /opt/local/bin \
    `find /usr/local -maxdepth 4 -type d -path '*/texlive/*/bin/x86_64-darwin'` \
    ~/bin \
    ~/.rvm/bin \
)
for _dir in ${potential_extra_dirs[@]}; do
    if [ -d ${_dir} ]; then
        PATH="${PATH}:${_dir}"
    fi
done

# Environment variables go here
export BLOCKSIZE=K
export EDITOR=vim
HISTFILE="${HOME}/.history"
export LANG=en_IE.UTF-8
export LC_COLLATE=C

# Include completion files
if [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
elif [[ -f /usr/local/etc/bash_completion ]]; then
    . /usr/local/etc/bash_completion
elif which brew > /dev/null 2>&1; then
    if [[ -f $(brew --prefix)/etc/bash_completion ]]; then
        . $(brew --prefix)/etc/bash_completion
    fi
fi

# Make a large history and share it between all sessions *and* with tcsh
shopt -s histappend
HISTFILE="${HOME}/.history"
HISTFILESIZE=10000
HISTSIZE=10000
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Set the prompt
GIT_PS1_SHOWDIRTYSTATE="true"
GIT_PS1_SHOWSTASHSTATE="true"
GIT_PS1_SHOWUNTRACKEDFILES="true"
GIT_PS1_SHOWUPSTREAM="auto"
PROMPT_COMMAND="rebuild_prompt; $PROMPT_COMMAND"
rebuild_prompt() {
    # Color setup
    blue="\[\033[1;34m\]"
    green="\[\033[32;48m\]"
    red="\[\033[31;48m\]"
    reset="\[\033[0m\]"
    white="\[\033[1;37m\]"

    # Host based coloring
    if [[ $(hostname) == "mcdermottr.vm.bytemark.co.uk" ]]; then
        host_color=${blue}
    else
        host_color=${white}
    fi

    # Make a colored git branch for inclusion in the prompt
    branch=$(__git_ps1 '%s')
    remote=$(git remote -v 2> /dev/null | grep '^origin.*fetch')
    if [[ ${remote} =~ "github" ]]; then
        owner=$(echo ${remote} | cut -d: -f2 | cut -d/ -f1)
        if [[ ${owner} == "conormcd" ]]; then
            if [[ ${branch} =~ "master" ]]; then
                branch="${red}${branch}${host_color} "
            else
                branch="${green}${branch}${host_color} "
            fi
        else
            branch="${red}${branch}${host_color} "
        fi
    elif [[ ${branch} ]]; then
        branch="${branch} "
    fi

    PS1="${host_color}\A [${branch}\W]>${reset} "
}

# Make sure we're using a colorized ls
if [[ $OSTYPE =~ "darwin" ]]; then
    alias ls='ls -Gh'
elif [[ $OSTYPE =~ "linux" ]]; then
    alias ls='ls --color=auto --human-readable'
fi
