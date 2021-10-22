#!/bin/bash -ue

source ~/dotfiles/scripts/utils/has.sh

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

# If you want to run, pass something as an argument
[ ! $# == 0 ] && check_brew
