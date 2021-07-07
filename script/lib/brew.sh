#!/bin/bash

# 実行したコマンドを表示
# set -x
set -ue

has() {
  type "$1" > /dev/null 2>&1
}

# CUI tools
target_brew_list=(
  ag
  ripgrep
  peco
  ghq
  tmux
  tig
  hub
  lazygit
  jq
  fzf
  bat
  git-flow
  gitmoji
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
)

# GUI tools
target_brew_cask_list=(
  chromedriver
  docker
  xquartz
  google-chrome
  spotify
  tableplus
  fork
  deepl
  typora
  teensy
  virtualbox
  visual-studio-code
  karabiner-elements
  postman
  homebrew/cask-versions/iterm2-nightly
  hyper
  alfred
)

# AppStore経由
# - Trello
# - Todoist
# - JIRA
# - Slack

if ! has "brew"; then
  echo "Installing Homebrew..."
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  echo "Homebrew has been already installed."
fi

echo "brew update..."
brew update

echo "brew upgrade..."
brew upgrade

for target in ${target_brew_list[@]}; do
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
