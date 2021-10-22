#!/bin/bash -u
# asdf plugin add でalready addedで終了してしまうので-eはつけない

source ~/dotfiles/scripts/utils/source_all_utils.sh

TARGET_LANGUAGES=(
  ruby
  nodejs
  python
  golang
  terraform
)

GLOBAL_RUBY_VERSION=2.6.6
RUBY_VERSIONS=(
  2.6.6
  2.7.4
)

GLOBAL_NODE_VERSION=12.20.1
NODE_VERSIONS=(
  12.20.1
  14.17.5
)

GLOBAL_PYTHON2_VERSION=2.7.16
GLOBAL_PYTHON3_VERSION=3.9.0
PYTHON_VERSIONS=(
  2.7.16
  3.9.0
)

GLOBAL_GOLANG_VERSION=1.12
GOLANG_VERSIONS=(
  1.12
)

GLOBAL_TERRAFORM_VERSION=0.14.5
TERRAFORM_VERSIONS=(
  0.14.5
)

install_languages() {
  for TARGET_LANG in ${TARGET_LANGUAGES[@]}; do
    echo "Install asdf plugin $TARGET_LANG..."
    asdf plugin add $TARGET_LANG

    case $TARGET_LANG in
      'ruby')
        for VERSION in ${RUBY_VERSIONS[@]}; do
          echo "Install $TARGET_LANG $VERSION..."
          asdf install $TARGET_LANG $VERSION
          asdf global $TARGET_LANG $GLOBAL_RUBY_VERSION
        done;;
      'nodejs')
        for VERSION in ${NODE_VERSIONS[@]}; do
          echo "Install $TARGET_LANG $VERSION..."
          asdf install $TARGET_LANG $VERSION
          asdf global $TARGET_LANG $GLOBAL_NODE_VERSION
        done;;
      'python')
        for VERSION in ${PYTHON_VERSIONS[@]}; do
          echo "Install $TARGET_LANG $VERSION..."
          asdf install $TARGET_LANG $VERSION
          asdf global $TARGET_LANG $GLOBAL_PYTHON2_VERSION
          asdf global $TARGET_LANG $GLOBAL_PYTHON3_VERSION
        done;;
      'golang')
        for VERSION in ${GOLANG_VERSIONS[@]}; do
          echo "Install $TARGET_LANG $VERSION..."
          asdf install $TARGET_LANG $VERSION
          asdf global $TARGET_LANG $GLOBAL_GOLANG_VERSION
        done;;
      'terraform')
        for VERSION in ${TERRAFORM_VERSIONS[@]}; do
          echo "Install $TARGET_LANG $VERSION..."
          asdf install $TARGET_LANG $VERSION
          asdf global $TARGET_LANG $GLOBAL_TERRAFORM_VERSION
        done;;
    esac
  done
}

set +e
check_brew
set -e

if has 'asdf'; then
  echo "asdf has been already installed."
  install_languages
else
  if ! has 'gpg'; then
    brew install gpg
  fi
  brew install asdf
  source ~/.config/fish/config.fish
  install_languages
fi
