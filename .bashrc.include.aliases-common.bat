@echo off
:: echo Included filename "%~f0"
::
:: Common DOS doskeyes
::

:: Fast access to Notepad
doskey n=notepad $*
doskey e=explorer . $*

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
doskey nr=npm run $*
doskey dm=docker-machine $*
doskey dc=docker-compose $*
doskey a=atom . $*

doskey weather=curl wttr.in/$1

doskey wresume=wget --content-disposition --continue --retry-connrefused --tries=0 --timeout=5 $*

doskey va=cmd /C "vagrant up && vagrant ssh"

doskey Ç…Ç·Å[ÇÒ=yarn $*

:: I'm in Windows now
doskey which=where $*
doskey ifconfig=ipconfig $*

doskey rawrec=rec -t raw -b 16 -c 1 -e s -r 24000 - $*
doskey rawplay=play -t raw -b 16 -c 1 -e s -r 24000 - $*
