#!/bin/bash

# 実行したコマンドを表示
# set -x
set -ue

PYTHON2_LATEST_LTS_VERSION=2.7.16
PYTHON3_LATEST_LTS_VERSION=3.8.0

has() {
  type "$1" > /dev/null 2>&1
}

target_global_python2_packages=(
  neovim
  pynvim
)
target_global_python3_packages=(
  neovim
  pynvim
)

if has "pyenv"; then

  ### Python2 ###
  if [[ -d "${PYENV_ROOT}/versions/${PYTHON2_LATEST_LTS_VERSION}"  ]]; then
    echo "python: $PYTHON2_LATEST_LTS_VERSION has been already installed."
  else
    pyenv install $PYTHON2_LATEST_LTS_VERSION
    pyenv global $PYTHON2_LATEST_LTS_VERSION
    pyenv rehash
  fi

  eval "$(pyenv init -)"
  pyenv init - | source
  pyenv virtualenv-init - | source
  if [[ -d "${PYENV_ROOT}/versions/neovim2" ]]; then
    echo "activate neovim2"
    pyenv activate neovim2
  else
    pyenv virtualenv 2.7.16 neovim2
    echo "activate neovim2"
    pyenv activate neovim2
  fi

  for target in ${target_global_python2_packages[@]}; do
    echo "Installing $target..."
    pip2 install --upgrade pip
    pip2 install $target
  done

  pyenv deactivate

  ### Python3 ###
  if [[ -d "${PYENV_ROOT}/versions/${PYTHON3_LATEST_LTS_VERSION}"  ]]; then
    echo "python: $PYTHON3_LATEST_LTS_VERSION has been already installed."
  else
    pyenv install $PYTHON3_LATEST_LTS_VERSION
    pyenv global $PYTHON3_LATEST_LTS_VERSION
    pyenv rehash
  fi

  if [[ -d "${PYENV_ROOT}/versions/neovim3" ]]; then
    echo "activate neovim3"
    pyenv activate neovim3
  else
    pyenv virtualenv 3.8.0 neovim3
    echo "activate neovim3"
    pyenv activate neovim3
  fi

  for target in ${target_global_python3_packages[@]}; do
    echo "Installing $target..."
    pip3 install --upgrade pip
    pip3 install $target
  done
  pyenv deactivate
else
  echo "Python is not installed."
fi

if ! has "pyenv-virtualenv"; then
  echo "Installing pyenv-virtualenv..."
  git clone git@github.com:pyenv/pyenv-virtualenv.git ${PYENV_ROOT}/plugins/pyenv-virtualenv
fi
