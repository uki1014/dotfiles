#!/bin/bash -ue

# STEP
# 1. check_dotfiles()
# 2. setup_tools()
#    - Setup brew
#    - Setup default shell
#    - Setup git-token.fish
#    - Setup asdf

has() {
  which $1 > /dev/null 2>&1
}

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

# dotfilesがない状態で実行するため、この行まではsourceができない
check_dotfiles

source ~/dotfiles/scripts/lib/asdf.sh
source ~/dotfiles/scripts/lib/brew_and_apt.sh
source ~/dotfiles/scripts/lib/git.sh
source ~/dotfiles/scripts/utils/source_all_utils.sh

setup_tools() {
  echo $(tput setaf 2)Setup tools...$(tput sgr0)

  # Setup Homebrew
  install_brew_packages

  # Setup default shell
  if [ ${SHELL} != "$(which fish)"  ]; then
    sudo chsh -s $(which fish) && true
    source ~/dotfiles/shell/fish/config.fish && true
  fi

  # Setup git-token.fish
  create_token_file

  # Setup asdf
  install_asdf

  echo $(tput setaf 2)Setup Tools complete!. ✔︎$(tput sgr0)
}

if [ $# == 0 ]; then
  setup_tools
  setup_symlink
else
  case $1 in
    "link")
      echo $(tput setaf 2)✔︎ Link files...$(tput sgr0)
      setup_symlink
      ;;
    "tools")
      echo $(tput setaf 2)✔︎ Setup tools...$(tput sgr0)
      setup_tools
      ;;
  esac
fi

exit 0
