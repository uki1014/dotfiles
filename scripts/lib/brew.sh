#!/bin/bash -ue

source ~/dotfiles/scripts/utils/source_all_utils.sh

# CUI tools
target_brew_list=(
  ag
  ripgrep
  peco
  tmux
  hub
  lazygit
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
  docui
  gpg
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
  alacritty
  figma
  sketch
  chromedriver
  firefox
  docker
  xquartz
  google-chrome
  # spotify
  tableplus
  fork
  deepl
  # typora
  teensy
  virtualbox
  visual-studio-code
  karabiner-elements
  postman
  # homebrew/cask-versions/iterm2-nightly
  hyper
  alfred
)

# AppStore経由
# - Trello
# - Todoist
# - JIRA
# - Slack

check_brew

for target in ${target_brew_list[@]}; do
  if ! has "$target"; then
    brew install $target
  else
    echo "$target has been already installed."
  fi
done

if is_darwin; then
  echo 'Darwin'
  for target in ${target_brew_list_for_mac_os[@]}; do
    if ! has "$target"; then
      brew install $target
    else
      echo "$target has been already installed."
    fi
  done

  for target in ${target_brew_cask_list[@]}; do
    if ! has "$target"; then
      brew install --cask $target
    else
      echo "$target has been already installed."
    fi
  done
else
  echo 'Linuxにはcask installしません'
fi
