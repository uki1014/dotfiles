#!/bin/bash -ue

source ~/dotfiles/scripts/utils/has.sh

check_brew() {
  if ! has "brew"; then
    echo $(tput setaf 2)Installing Homebrew...$(tput sgr0)
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh && true
  else
    echo $(tput setaf 2)Homebrew has been already installed.$(tput sgr0)

    echo $(tput setaf 2)brew update$(tput sgr0)
    brew update && true

    echo $(tput setaf 2)brew upgrade...$(tput sgr0)
    brew upgrade && true


    echo $(tput setaf 2)brew doctor...$(tput sgr0)
    brew doctor && true

    echo $(tput setaf 2)brew cleanup...$(tput sgr0)
    brew cleanup && true
  fi
}

# If you want to run, pass something as an argument
if [ $# != 0 ]; then
  check_brew
fi
