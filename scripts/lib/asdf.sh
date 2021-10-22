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
RUBY_GLOBAL_PACKAGES=(
  solargraph
  neovim
)

GLOBAL_NODE_VERSION=12.20.1
NODE_VERSIONS=(
  12.20.1
  14.17.5
)
NODE_GLOBAL_PACKAGES=(
  neovim
  yarn
  typescript
)

GLOBAL_PYTHON2_VERSION=2.7.16
GLOBAL_PYTHON3_VERSION=3.9.0
PYTHON2_GLOBAL_PACKAGES=(
  neovim
  pynvim
)
PYTHON3_GLOBAL_PACKAGES=(
  neovim
  pynvim
)

GLOBAL_GOLANG_VERSION=1.12
GOLANG_VERSIONS=(
  1.12
)

GLOBAL_TERRAFORM_VERSION=0.14.5
TERRAFORM_VERSIONS=(
  0.14.5
)

TARGET_TOOLS=(
  neovim
  # awscli
  docker-compose-v1
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

          for PACKAGE in $RUBY_GLOBAL_PACKAGES; do
            gem install $PACKAGE
          done
        done;;
      'nodejs')
        for VERSION in ${NODE_VERSIONS[@]}; do
          echo "Install $TARGET_LANG $VERSION..."
          asdf install $TARGET_LANG $VERSION
          asdf global $TARGET_LANG $GLOBAL_NODE_VERSION

          for PACKAGE in $NODE_GLOBAL_PACKAGES; do
            npm install -g $PACKAGE
          done
        done;;
      'python')
        echo "Install Python $GLOBAL_PYTHON3_VERSION..."
        asdf install python $GLOBAL_PYTHON3_VERSION

        echo "Install Python $GLOBAL_PYTHON2_VERSION..."
        asdf install python $GLOBAL_PYTHON2_VERSION

        asdf global python $GLOBAL_PYTHON3_VERSION $GLOBAL_PYTHON2_VERSION

        for PACKAGE in $PYTHON2_GLOBAL_PACKAGES; do
          pip2 install --upgrade pip
          pip2 install $PACKAGE
          pip2 install --upgrade $PACKAGE
        done

        for PACKAGE in $PYTHON3_GLOBAL_PACKAGES; do
          pip3 install --upgrade pip
          pip3 install $PACKAGE
          pip3 install --upgrade $PACKAGE
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

install_tools() {
  for TARGET_TOOL in ${TARGET_TOOLS[@]}; do
    echo "Install asdf plugin $TARGET_TOOL..."
    asdf plugin add $TARGET_TOOL

    case $TARGET_TOOL in
      'neovim')
        echo "Install $TARGET_TOOL..."
        asdf install $TARGET_TOOL stable
        asdf global $TARGET_TOOL stable
        ;;
      'docker-compose-v1')
        echo "Install $TARGET_TOOL..."
        asdf install $TARGET_TOOL 1.29.2
        asdf global $TARGET_TOOL 1.29.2
        ;;
    esac
  done
}

set +e
check_brew
set -e

if has 'asdf'; then
  echo "asdf has been already installed."
  install_languages
  install_tools
else
  if ! has 'gpg'; then
    brew install gpg
  fi
  brew install asdf
  source ~/.config/fish/config.fish
  install_languages
  install_tools
fi