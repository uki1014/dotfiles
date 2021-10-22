#!/bin/bash

# 実行したコマンドを表示
# set -x
set -ue

GO_LATEST_LTS_VERSION=1.13.15

has() {
  type "$1" > /dev/null 2>&1
}

target_global_go_packages=(
)

if has "goenv"; then
  if [[ -d "${GOENV_ROOT}/versions/${GO_LATEST_LTS_VERSION}"  ]]; then
    echo "ruby: $GO_LATEST_LTS_VERSION has been already installed."
  else
    goenv install $GO_LATEST_LTS_VERSION
    goenv global $GO_LATEST_LTS_VERSION
    goenv rehash
  fi

  # eval "$(goenv init -)"
  # for target in ${target_global_go_packages[@]}; do
  #   echo "Installing $target..."
  #   go get -g $target
  # done

else
  echo "Go is not installed."
fi
