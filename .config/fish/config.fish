# Path to Oh My Fish install.
set -gx OMF_PATH "/home/hakatashi/.local/share/omf"

source $OMF_PATH/init.fish

# Path to your custom folder (default path is ~/.oh-my-fish/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

set --export LD_LIBRARY_PATH $HOME/lib:$HOME/lib64

set --export LD_PRELOAD "$HOME/stderred/build/libstderred.so"

# baliases
balias push 'git push origin HEAD'

balias cp 'cp -i -p'
balias mv 'mv -i'

balias ll 'ls -alh'
balias la 'ls -A'
balias l 'ls -CF'

balias .. 'cd ..'
balias ... 'cd ../..'
balias .... 'cd ../../..'
balias ..... 'cd ../../../..'
balias ...... 'cd ../../../../..'

balias :q 'exit'

balias push 'git push origin HEAD'

balias gitroot 'cd (git rev-parse --show-toplevel)'
balias unit 'set cwd (pwd); and cd (git rev-parse --show-toplevel); and cd pixiv-lib/unit_test; ./phpunit; cd $cwd'

function phpunit
    command phpunit --colors
end

function less
    command less -R
end

function fuck -d 'Correct your previous console command'
    set -l exit_code $status
    set -l eval_script (mktemp 2>/dev/null ; or mktemp -t 'thefuck')
    set -l fucked_up_commandd $history[1]
    thefuck $fucked_up_commandd > $eval_script
    . $eval_script
    rm $eval_script
    if test $exit_code -ne 0
        history --delete $fucked_up_commandd
    end
end

balias f 'fuck'

# binds

# hub config
command --search hub > /dev/null; and begin
    eval (hub alias -s)
end

# rbenv
if test -d ~/.rbenv
    status --is-interactive; and . (rbenv init -|psub)
end

# https://gist.github.com/rsff/9366074
setenv SSH_ENV $HOME/.ssh/environment

function start_agent
    if [ -n "$SSH_AGENT_PID" ]
            ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
            if [ $status -eq 0 ]
                test_identities
            end
    else
            if [ -f $SSH_ENV ]
                . $SSH_ENV > /dev/null
            end
        ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
        if [ $status -eq 0 ]
            test_identities
        else
            echo "Initializing new SSH agent ..."
            ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
            echo "succeeded"
        chmod 600 $SSH_ENV 
        . $SSH_ENV > /dev/null
            ssh-add
    end
    end
end

function test_identities
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $status -eq 0 ]
        ssh-add
        if [ $status -eq 2 ]
            start_agent
        end
    end
end

function fish_title
    if [ $_ = 'fish' ]
    echo (prompt_pwd)
    else
        echo $_
    end
end
