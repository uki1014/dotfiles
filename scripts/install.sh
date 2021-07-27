#!/bin/bash

# 実行したコマンドを表示
# set -x
set -ue
OS="$(uname -s)"
DOT_DIRECTORY="${HOME}/dotfiles"
DOT_TARBALL="https://github.com/uki1014/dotfiles/tarball/master"
DOT_REMOTE_URL="https://github.com/uki1014/dotfiles.git"

function has() {
  type "$1" > /dev/null 2>&1
}

function usage() {
  name=`basename $0`
  cat << EOF
Usage:
  $name [arguments] [command]
Commands:
  ~/dotfiles/script/install.sh link
  ~/dotfiles/script/install.sh tools
EOF
}


# Install my dotfile
function check_dotfiles() {
  if [ ! -d ${DOT_DIRECTORY} ]; then
    echo "Downloading dotfiles..."

    mkdir dotfiles

    if has "git"; then
      # git cloneするディレクトリは空である必要があるので先にdotfilesディレクトリを作成し、
      # そのディレクトリの中に中身だけをcloneする
      git clone ${DOT_REMOTE_URL} ${DOT_DIRECTORY}
    else
      curl -fsSLo ${HOME}/dotfiles.tar.gz ${DOT_TARBALL}
      tar -zxf ${HOME}/dotfiles.tar.gz --strip-components 1 -C ${DOT_DIRECTORY}
      rm -f ${HOME}/dotfiles.tar.gz
    fi

    echo $(tput setaf 2)Download dotfiles complete!. ✔︎$(tput sgr0)
  fi
  cd ${DOT_DIRECTORY}
}

function setup_tools() {
  echo 'setup tools...'

  # Setup Homebrew
  ~/dotfiles/script/lib/brew.sh

  # Setup default shell
  [ ${SHELL} != "$(which fish)"  ] && sudo chsh -s $(which fish)

  # Setup Neovim nightly
  ~/dotfiles/script/lib/neovim.sh

  # Setup anyenv
  ~/dotfiles/script/lib/anyenv.sh

  echo $(tput setaf 2)Setup Tools complete!. ✔︎$(tput sgr0)
}

# Setup Symbolic links
function setup_symlink() {
  ~/dotfiles/script/setup_symlink.sh

  echo $(tput setaf 2)Setup symbolic links complete!. ✔︎$(tput sgr0)
}

###################
#####   main  #####
###################
check_dotfiles

if [ $# == 0 ]; then
  echo "Initialize all..."
  setup_tools
  setup_symlink
else
  case $1 in
    "link")
      echo 'link files...'
      setup_symlink
      ;;
    "tools")
      setup_tools
      ;;
    "help")
      usage
      ;;
  esac
fi

exit 0
