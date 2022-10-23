#!/bin/bash -ue

source ~/dotfiles/scripts/utils/source_all_utils.sh

TARGET_LANGUAGES=(
  ruby
  nodejs
  python
  golang
)

GLOBAL_RUBY_VERSION=2.6.6
RUBY_VERSIONS=(
  2.7.6
)
RUBY_GLOBAL_PACKAGES=(
  solargraph
  neovim
  awesome_print
)

GLOBAL_NODE_VERSION=14.18.2
NODE_VERSIONS=(
  14.18.2
  16.14.2
)
NODE_GLOBAL_PACKAGES=(
  neovim
  yarn
  typescript
)

GLOBAL_GOLANG_VERSION=1.18.1
GOLANG_VERSIONS=(
  1.18.1
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
    echo $(tput setaf 2)Install asdf plugin $TARGET_LANG...$(tput sgr0)
    asdf plugin add $TARGET_LANG && true # すでにpluginが入っているとexit2してしまうのでtrue

    case $TARGET_LANG in
      'ruby')
        for VERSION in ${RUBY_VERSIONS[@]}; do
          echo $(tput setaf 2)Install $TARGET_LANG $VERSION...$(tput sgr0)
          asdf install $TARGET_LANG $VERSION
          asdf global $TARGET_LANG $GLOBAL_RUBY_VERSION

          for PACKAGE in $RUBY_GLOBAL_PACKAGES; do
            gem install $PACKAGE
          done
          asdf reshim $TARGET_LANG
        done;;
      'nodejs')
        for VERSION in ${NODE_VERSIONS[@]}; do
          echo $(tput setaf 2)Install $TARGET_LANG $VERSION...$(tput sgr0)
          asdf install $TARGET_LANG $VERSION
          asdf global $TARGET_LANG $GLOBAL_NODE_VERSION

          for PACKAGE in $NODE_GLOBAL_PACKAGES; do
            npm install -g $PACKAGE
          done
          asdf reshim $TARGET_LANG
        done;;
      'golang')
        for VERSION in ${GOLANG_VERSIONS[@]}; do
          echo $(tput setaf 2)Install $TARGET_LANG $VERSION...$(tput sgr0)
          asdf install $TARGET_LANG $VERSION
          asdf global $TARGET_LANG $GLOBAL_GOLANG_VERSION
          asdf reshim $TARGET_LANG
        done;;
      'terraform')
        for VERSION in ${TERRAFORM_VERSIONS[@]}; do
          echo $(tput setaf 2)Install $TARGET_LANG $VERSION...$(tput sgr0)
          asdf install $TARGET_LANG $VERSION
          asdf global $TARGET_LANG $GLOBAL_TERRAFORM_VERSION
          asdf reshim $TARGET_LANG
        done;;
    esac
  done
}

install_tools() {
  for TARGET_TOOL in ${TARGET_TOOLS[@]}; do
    echo $(tput setaf 2)Install asdf plugin $TARGET_TOOL...$(tput sgr0)
    asdf plugin add $TARGET_TOOL && true

    case $TARGET_TOOL in
      'neovim')
        echo $(tput setaf 2)Install $TARGET_TOOL...$(tput sgr0)
        asdf install $TARGET_TOOL stable
        asdf global $TARGET_TOOL stable
        ;;
      'docker-compose-v1')
        echo $(tput setaf 2)Install $TARGET_TOOL...$(tput sgr0)
        asdf install $TARGET_TOOL 1.29.2
        asdf global $TARGET_TOOL 1.29.2
        ;;
    esac
  done
  # nvim上で使うpluginをinstall
  go install github.com/skanehira/getpr@latest
}


install_asdf() {
  if has 'asdf'; then
    echo $(tput setaf 2)asdf has been already installed.$(tput sgr0)
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
}

if [ $# != 0 ]; then
  check_brew

  install_asdf
fi
