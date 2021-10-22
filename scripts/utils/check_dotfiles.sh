#!/bin/bash -ue

source ~/dotfiles/scripts/utils/has.sh

DOTFILES_DIR="$HOME/dotfiles"
DOT_TARBALL="https://github.com/uki1014/dotfiles/tarball/master"
DOT_REMOTE_URL="https://github.com/uki1014/dotfiles.git"

check_dotfiles() {
  if [ ! -d $DOTFILES_DIR ]; then
    echo "Downloading dotfiles..."

    mkdir $DOTFILES_DIR

    if has "git"; then
      # The directory to clone needs to be empty,
      # so you'll need to create a dotfiles directory first, then clone the contents into that directory.
      git clone ${DOT_REMOTE_URL} ${DOTFILES_DIR}
    else
      curl -fsSLo ${HOME}/dotfiles.tar.gz ${DOT_TARBALL}
      tar -zxf ${HOME}/dotfiles.tar.gz --strip-components 1 -C ${DOTFILES_DIR}
      rm -f ${HOME}/dotfiles.tar.gz
    fi

    echo $(tput setaf 2)Download dotfiles complete!. ✔︎$(tput sgr0)
    cd $DOTFILES_DIR
  else
    echo "your Dotfiles has been already installed."
  fi
}

# If you want to run, pass something as an argument
if [ $# != 0 ]; then
  check_dotfiles
fi
