#!/bin/bash

# 実行したコマンドを表示
# set -x
set -ue

if [ ! -d ${HOME}/.anyenv ]; then
  git clone https://github.com/anyenv/anyenv ~/.anyenv
  ~/.anyenv/bin/anyenv init
  anyenv install goenv
  anyenv install rbenv
  anyenv install pyenv
  anyenv install nodenv
  anyenv install tfenv
  exec $SHELL -l

  ~/dotfiles/script/lib/node.sh
  ~/dotfiles/script/lib/ruby.sh
  ~/dotfiles/script/lib/python.sh
  ~/dotfiles/script/lib/go.sh
else
  echo "anyenv has been already installed."
fi

if [ ! -d ${HOME}/.anyenv/plugins ]; then
  mkdir -p $(anyenv root)/plugins
  git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
  anyenv update
fi
