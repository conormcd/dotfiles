# PROMPT_COMMAND is appended to. Reset it to avoid making it huge if this file
# is sourced multiple times.
PROMPT_COMMAND=""

# Make sure the path covers everything
PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:${HOME}/bin"

# Environment variables go here
export BLOCKSIZE=K
export EDITOR=vim
HISTFILE="${HOME}/.history"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export LANG=en_IE.UTF-8
export LC_COLLATE=C
export LESS=-FXRS
export PERL_LOCAL_LIB_ROOT="$HOME/.perl5lib"
export PERL_MB_OPT="--install_base $HOME/.perl5lib"
export PERL_MM_OPT="INSTALL_BASE=$HOME/.perl5lib"
export PERL5LIB="$HOME/.perl5lib/lib/perl5/darwin-2level:$HOME/.perl5lib/lib/perl5"
export PATH="$PATH:/Users/conor/.perl5lib/bin"
if [ -x /usr/libexec/java_home ]; then
    _java_home=$(/usr/libexec/java_home)
    if [[ $? = 0 && -n "${_java_home}" ]]; then
        export JAVA_HOME="${_java_home}"
    fi
fi

# Include completion files
if [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
fi
if [[ -f /usr/local/share/bash-completion/bash_completion ]]; then
    . /usr/local/share/bash-completion/bash_completion
fi
if [[ -d ~/.bash/completion ]]; then
    for cmpl in $(find ~/.bash/completion -type f); do
        . ${cmpl}
    done
fi

# Make a large history and share it between all sessions *and* with tcsh
shopt -s histappend
HISTFILE="${HOME}/.history"
HISTFILESIZE=1000
HISTSIZE=1000
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Set the prompt
GIT_PS1_SHOWDIRTYSTATE="true"
GIT_PS1_SHOWSTASHSTATE="true"
GIT_PS1_SHOWUNTRACKEDFILES="true"
GIT_PS1_SHOWUPSTREAM="auto"
if [ -f /usr/local/share/git-core/contrib/completion/git-prompt.sh ]; then
    . /usr/local/share/git-core/contrib/completion/git-prompt.sh
fi
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
    if [[ -n ${branch} ]]; then
        remote=$(git remote -v 2> /dev/null | grep '^origin.*fetch')
        if [[ ${remote} =~ "github" ]]; then
            if [[ ${remote} == ":conormcd/" ]]; then
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
    fi

    PS1="${host_color}\A [${branch}\W]>${reset} "
}

# Git aliases
alias gd="git diff"
alias gdc="git diff --cached"
alias gdcw="git diff -u -b -w --cached"
alias gdw="git diff -u -b -w"
alias gdwc="git diff -u -b -w --cached"
alias gl="pretty_git_log"
alias gs="git status"
pretty_git_log() {
    local _time="%C(green)%ar{%C(reset)"
    local _author="%C(bold blue)%aN%C(reset){"
    local _ref="%C(red)%d%C(reset)"
    local _message="%s"

    git \
        log \
        --graph \
        --pretty="tformat:${_time}${_author}${_ref} ${_message}" \
        "$@" \
        | sed -e 's/ ago{/{/' \
        | column -t -s '{' \
        | less -FXSR
}

# Make sure we're using a colorized ls
if [[ $OSTYPE =~ "darwin" ]]; then
    alias ls='ls -Gh'
elif [[ $OSTYPE =~ "linux" ]]; then
    alias ls='ls --color=auto --human-readable'
fi

# Make sure the gpg-agent is running
if ! pgrep gpg-agent > /dev/null 2>&1; then
    eval "$(gpg-agent --daemon)"
fi
export GPG_AGENT_INFO
export GPG_TTY=$(tty)
export LEIN_GPG=gpg2

export CI=true
export CIRCLE_ENV=test
export NREPL_PORT=6005
