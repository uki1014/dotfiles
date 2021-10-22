#!/bin/bash -ue

if [ ! -d ${HOME}/.anyenv ]; then
  git clone https://github.com/anyenv/anyenv ~/.anyenv
  ~/.anyenv/bin/anyenv init
  anyenv install goenv
  anyenv install rbenv
  anyenv install pyenv
  anyenv install nodenv
  anyenv install tfenv
  exec $SHELL -l

  ~/dotfiles/scripts/lib/node.sh
  ~/dotfiles/scripts/lib/ruby.sh
  ~/dotfiles/scripts/lib/python.sh
  ~/dotfiles/scripts/lib/go.sh
else
  echo "anyenv has been already installed."
fi

if [ ! -d ${HOME}/.anyenv/plugins ]; then
  mkdir -p ${ANYENV_ROOT}/plugins
  git clone https://github.com/znz/anyenv-update.git ${ANYENV_ROOT}/plugins/anyenv-update
  anyenv update
fi
