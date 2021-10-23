#!/bin/bash -ue

source ~/dotfiles/scripts/utils/has.sh

DOTFILES_DIR="$HOME/dotfiles"
DOT_TARBALL="https://github.com/uki1014/dotfiles/tarball/master"
DOT_REMOTE_URL="https://github.com/uki1014/dotfiles.git"

check_dotfiles() {
  if [ ! -d $DOTFILES_DIR ]; then
    echo $(tput setaf 2)Downloading dotfiles...$(tput sgr0)

    mkdir $DOTFILES_DIR

    if has "git"; then
      # The directory to clone needs to be empty,
      # so you'll need to create a dotfiles directory first, then clone the contents into that directory.
      git clone ${DOT_REMOTE_URL} ${DOTFILES_DIR} && true
    else
      curl -fsSLo ${HOME}/dotfiles.tar.gz ${DOT_TARBALL}
      tar -zxf ${HOME}/dotfiles.tar.gz --strip-components 1 -C ${DOTFILES_DIR}
      rm -f ${HOME}/dotfiles.tar.gz && true
    fi

    echo $(tput setaf 2)Download dotfiles complete!. ✔︎$(tput sgr0)
    cd $DOTFILES_DIR
  else
    echo $(tput setaf 2)Your dotfiles has been already installed.$(tput sgr0)
  fi
}

# If you want to run, pass something as an argument
if [ $# != 0 ]; then
  check_dotfiles
fi
