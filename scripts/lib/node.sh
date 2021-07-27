#!/bin/bash

# 実行したコマンドを表示
# set -x
set -ue

NODEJS_LATEST_LTS_VERSION=12.13.0

has() {
  type "$1" > /dev/null 2>&1
}

target_global_node_packages=(
  neovim
  typescript
  ts-node
)

if has "nodenv"; then
  if [[ -d "${NODENV_ROOT}/versions/${NODEJS_LATEST_LTS_VERSION}"  ]]; then
    echo "node: $NODEJS_LATEST_LTS_VERSION has been already installed."
  else
    nodenv install $NODEJS_LATEST_LTS_VERSION
    nodenv global $NODEJS_LATEST_LTS_VERSION
    nodenv rehash
  fi

  eval "$(nodenv init -)"
  for target in ${target_global_node_packages[@]}; do
    echo "Installing $target..."
    npm install -g $target
  done
else
  echo "Node.js is not installed."
fi
