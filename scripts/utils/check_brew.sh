#!/bin/bash -ue

source ~/dotfiles/scripts/utils/source_all_utils.sh

check_brew() {
  if ! has "brew"; then
    echo "Installing Homebrew..."
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh
  else
    echo "Homebrew has been already installed."

    echo "brew update..."
    brew update

    echo "brew upgrade..."
    brew upgrade


    echo "brew doctor..."
    brew doctor

    echo "brew cleanup..."
    brew cleanup
  fi
}

# 引数になにか渡せばcheck_brewを実行できる
[ ! $# == 0 ] && check_brew
