#!/bin/bash -u

source ~/dotfiles/scripts/utils/source_all_utils.sh

# CUI tools
target_brew_list=(
  ag
  ripgrep
  peco
  tmux
  hub
  lazygit
  lazydocker
  jq
  fzf
  bat
  git-flow
  git
  tree
  direnv
  watch
  gh
  htop
  fish
  reattach-to-user-namespace
  shared-mime-info
  tree-sitter
  luajit
  gpg
  fd
  neofetch
  mycli
  shellcheck
)

# CUI tools for macOS
target_brew_list_for_mac_os=(
  coreutils
  findutils
  gnu-sed
  grep
  gzip
  gawk
  gnu-tar
  wget
)

# GUI tools
target_brew_cask_list=(
  figma
  chromedriver
  firefox
  docker
  xquartz
  google-chrome
  spotify
  tableplus
  deepl
  typora
  teensy
  virtualbox
  visual-studio-code
  karabiner-elements
  postman
  homebrew/cask-versions/iterm2-nightly
  alfred
)

# AppStore経由
# - Trello
# - Todoist
# - JIRA
# - Slack

install_brew_packages() {
  check_brew

  for target in ${target_brew_list[@]}; do
    if ! has "$target"; then
      brew install $target
    else
      echo $(tput setaf 2)$target has been already installed.$(tput sgr0)
    fi
  done

  if is_darwin; then
    echo $(tput setaf 2)Darwin$(tput sgr0)
    for target in ${target_brew_list_for_mac_os[@]}; do
      if ! has "$target"; then
        brew install $target
      else
        echo $(tput setaf 2)$target has been already installed.$(tput sgr0)
      fi
    done

    for target in ${target_brew_cask_list[@]}; do
      if ! has "$target"; then
        brew install --cask $target
      else
        echo $(tput setaf 2)$target has been already installed.$(tput sgr0)
      fi
    done
  else
    echo $(tput setaf 2)No cask install for Linux.$(tput sgr0)
  fi
}

if [ $# != 0 ]; then
  install_brew_packages
fi
