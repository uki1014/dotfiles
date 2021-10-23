#!/bin/bash -u

# STEP
# 1. check_dotfiles()
# 2. setup_tools()
#    - Setup brew
#    - Setup default shell
#    - Setup asdf

source ~/dotfiles/scripts/lib/asdf.sh
source ~/dotfiles/scripts/lib/brew.sh
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

  # Setup asdf
  install_asdf

  echo $(tput setaf 2)Setup Tools complete!. ✔︎$(tput sgr0)
}

check_dotfiles

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
