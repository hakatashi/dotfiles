# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

SCRIPT_PATH="$(readlink -m "$BASH_SOURCE")"

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Set tab size
tabs 4

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
#force_color_prompt=yes

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias cp='cp -i -p'
alias mv='mv -i'

alias ll='ls -alh'
alias la='ls -A'
alias l='ls -CF'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias push='git push origin HEAD'
alias phpunit='\phpunit --colors'
alias less='\less -R'

alias wresume='wget --content-disposition --continue --retry-connrefused --tries=0 --timeout=5'

alias fuck='eval $(thefuck $(fc -ln -1)); history -r'
alias f='fuck'

alias be='bundle exec'
alias bers='bundle exec rails server'
alias befs='bundle exec foreman start'
alias nr='npm run'
alias dm='docker-machine'
alias dc='docker-compose'
alias a='atom .'
alias v='code-insiders .'

alias weather='curl wttr.in'

# I'm in UNIX now
alias where=which
alias ipconfig=ifconfig

alias rawrec='rec -t raw -b 16 -c 1 -e s -r 24000 -'
alias rawplay='play -t raw -b 16 -c 1 -e s -r 24000 -'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export TEST_SERVER=1

if hash links 2> /dev/null; then
    export BROWSER=links
elif hash lynx 2> /dev/null; then
    export BROWSER=lynx
fi

export EDITOR=vim

source ~/.bash/.git-completion.bash
source ~/.bash/.git-prompt.sh

# Enable `npm -g` without sudo
# Thanks: https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md
NPM_PACKAGES="${HOME}/.npm-packages"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
PATH="$NPM_PACKAGES/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath`
# command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

PS1='[\[\e[1;34m\]\w\[\e[m\]\[\e[0;32m\]$(__git_ps1 " (%s)")\[\e[m\]]\$ '

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-isotope.dark.sh"
[[ -s $BASE16_SHELL  ]] && source $BASE16_SHELL

# alias hub to git if exists
if hash hub 2> /dev/null; then
    eval "$(hub alias -s)"
fi

# Disable XON feature, which take C-s from vim
# Thanks: http://unix.stackexchange.com/a/72092
stty -ixon

# Shelly integration
SHELLY_HOME="$HOME/.shelly"; [ -s "$SHELLY_HOME/lib/shelly/init.sh" ] && . "$SHELLY_HOME/lib/shelly/init.sh"

# Setup rbenv
if [ -d "$HOME/.rbenv" ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

# pyenv
if [ -d "$HOME/.pyenv" ]; then
  export PATH="/home/hakatashi/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# Setup nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && nvm use node
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Setup bin directory as path of script
export PATH="$(dirname "$SCRIPT_PATH")/bin:$PATH"

# Setup pyenv
if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# Setup srilm
if [ -d "$HOME/srilm-dir/bin/i686-m64" ]; then
    export PATH="~/srilm-dir/bin/i686-m64:$PATH"
fi

# Setup torch
if [ -s "$HOME/torch/install/bin/torch-activate" ]; then
    . ~/torch/install/bin/torch-activate
fi

# Setup Heroku Toolbelt
if [ -d "/usr/local/heroku/bin" ]; then
    export PATH="/usr/local/heroku/bin:$PATH"
fi

# Setup Go
if [ -d "/usr/local/go/bin" ]; then
    export PATH="/usr/local/go/bin:$PATH"
fi

# Setup Promptline
if [ -s "$HOME/.shell_prompt.sh" ]; then
    . "$HOME/.shell_prompt.sh"
fi

export DOCKER_CERT_PATH=/mnt/c/Users/denjj/.docker/machine/machines/default
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
