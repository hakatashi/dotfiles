@echo off
:: echo Included filename "%~f0"
::
:: Common DOS doskeyes
::

:: Fast access to Notepad
doskey n=notepad $*
doskey e=explorer $*

doskey ls=ls --color=auto $*
doskey grep=grep --color=auto $*

doskey cp=cp -i -p $*
doskey mv=mv -i $*

doskey ll=ls -alh --color=auto $*
doskey la=ls -A --color=auto $*
doskey l=ls -CF --color=auto $*

doskey ..=cd ..
doskey ...=cd ../..
doskey ....=cd ../../..
doskey .....=cd ../../../..
doskey ......=cd ../../../../..

doskey push=git push origin HEAD
doskey phpunit=phpunit --colors $*
doskey less=less -R $*

doskey be=bundle exec $*
doskey bers=bundle exec rails server $*
doskey a=atom . $*

doskey weather=curl wttr.in/$1

doskey wresume=wget --continue --retry-connrefused --tries=0 --timeout=5 $*

doskey va=cmd /C "vagrant up && vagrant ssh"
