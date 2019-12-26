#!/bin/bash

files=".bash .config .vim .bashrc .editorconfig .gitconfig .gvimrc .inputrc .tmux.conf .uncrustify.cfg .vimrc .Xmodmap .zshrc"

mkdir -p ~/dotfiles.backup
cd `dirname $0`

for file in $files; do
  if [ -f "~/$file" ]; do
    mv ~/$file ~/dotfiles.backup/
  done
  ln -s $file ~/.$file
done
