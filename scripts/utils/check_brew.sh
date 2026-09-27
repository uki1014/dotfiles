#!/bin/bash -ue

source ~/dotfiles/scripts/utils/has.sh

check_brew() {
  if ! has "brew"; then
    echo $(tput setaf 2)Installing Homebrew...$(tput sgr0)
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # 新規インストール直後はPATHに乗っていないので、この後のbrew呼び出しのために読み込む
    for BREW_BIN in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
      if [ -x $BREW_BIN ]; then
        eval "$($BREW_BIN shellenv)"
        break
      fi
    done
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
