# If not running interactively, don't do anything
[ -z "$PS1" ] && return


#### Bash ####

# don't put duplicate lines in the history
export HISTCONTROL=ignoredups:erasedups

export HISTSIZE=5000
export HISTFILESIZE=5000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command
shopt -s checkwinsize

# Set tab size
tabs 4

# make less more friendly for non-text input files
if [ -x /usr/bin/lesspipe ]; then
    eval "$(SHELL=/bin/sh lesspipe)"
fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

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
alias v='code-insiders --add .'
alias drun='docker run -it --rm -v $PWD:/code -w /code'

alias weather='curl wttr.in'

# I'm in UNIX now
alias where=which
alias ipconfig=ifconfig
alias e='open .'

alias rawrec='rec -t raw -b 16 -c 1 -e s -r 24000 -'
alias rawplay='play -t raw -b 16 -c 1 -e s -r 24000 -'

alias ntp='sudo sntp -sS ntp.nict.jp'

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

for file in `ls ~/.bash/{.*,*}.{sh,bash} 2> /dev/null`; do
    source $file
done

# Enable `npm -g` without sudo
# Thanks: https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md
NPM_PACKAGES="${HOME}/.npm-packages"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
PATH="$NPM_PACKAGES/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath`
# command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

get_datetime_color () {
    if [ $? = 0 ]; then
        echo 30
    else
        echo 31
    fi
}
PS1='\n[\[\e[1;34m\]\w\[\e[m\] \[\e[1;$(get_datetime_color)m\]\t\[\e[m\]]\[\e[0;32m\]$(__git_ps1 " (%s)")\[\e[m\]\n\$ '

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-isotope.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

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

# Setup pyenv
if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    if [ -d "$PYENV_ROOT/plugins/pyenv-virtualenv" ]; then
        eval "$(pyenv virtualenv-init -)"
    fi
fi

# Setup nvm
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"
    nvm use node
fi

# Setup nvm bash completion
if [ -s "$NVM_DIR/bash_completion" ]; then
    . "$NVM_DIR/bash_completion"
fi

# Setup bin directory as path of script
SCRIPT_PATH="$(readlink "$BASH_SOURCE")"
export PATH="$(dirname "$SCRIPT_PATH")/bin:$PATH"

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

# Setup Docker Machine for Windows
if [ -d "/mnt/c/Users/denjj/.docker/machine/machines/default" ]; then
    export DOCKER_CERT_PATH=/mnt/c/Users/denjj/.docker/machine/machines/default
fi

# Setup Cargo
if [ -d "$HOME/.cargo" ]; then
    source "$HOME/.cargo/env"
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="$PATH:$HOME/.local/bin"

# temporarily disable ssh-agent, since it hangs on macOS
unset SSH_AUTH_SOCK
