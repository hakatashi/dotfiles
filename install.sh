#!/bin/bash

files=".bash .config .vim .bashrc .bash_profile .editorconfig .gitconfig .gvimrc .inputrc .tmux.conf .uncrustify.cfg .vimrc .Xmodmap .zshrc"

mkdir -p ~/dotfiles.backup
cd `dirname $0`

for file in $files; do
  if [ -L "$HOME/$file" ]; then
    continue
  fi
  if [ -f "$HOME/$file" ]; then
    mv $HOME/$file $HOME/dotfiles.backup/
  fi
  echo "Installing $file..."
  ln -s $PWD/$file $HOME/$file
done
