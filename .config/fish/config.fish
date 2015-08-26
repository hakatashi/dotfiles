# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Path to your custom folder (default path is ~/.oh-my-fish/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

# Custom plugins and themes may be added to ~/.oh-my-fish/custom
# Plugins and themes can be found at https://github.com/oh-my-fish/
Theme 'robbyrussell'
Plugin 'theme'
Plugin 'emoji-clock'
Plugin 'extract'
Plugin 'balias'

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

