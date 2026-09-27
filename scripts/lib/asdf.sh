#!/bin/bash -ue

source ~/dotfiles/scripts/utils/source_all_utils.sh

TARGET_LANGUAGES=(
  nodejs
  terraform
  golang
)

NODE_GLOBAL_PACKAGES=(
  neovim
  typescript
)

TARGET_TOOLS=(
  neovim
  # awscli
)

install_languages() {
  for TARGET_LANG in ${TARGET_LANGUAGES[@]}; do
    echo $(tput setaf 2)Install asdf plugin $TARGET_LANG...$(tput sgr0)
    asdf plugin add $TARGET_LANG && true # すでにpluginが入っているとexit2してしまうのでtrue

    case $TARGET_LANG in
      'nodejs')
        # 固定バージョンを持たず、実行時点の最新を入れてglobalにする
        VERSION=$(asdf latest $TARGET_LANG)
        echo $(tput setaf 2)Install $TARGET_LANG $VERSION...$(tput sgr0)
        asdf install $TARGET_LANG $VERSION
        asdf set -u $TARGET_LANG $VERSION

        for PACKAGE in ${NODE_GLOBAL_PACKAGES[@]}; do
          asdf exec npm install -g $PACKAGE
        done
        asdf reshim $TARGET_LANG
        ;;
      'golang')
        VERSION=$(asdf latest $TARGET_LANG)
        echo $(tput setaf 2)Install $TARGET_LANG $VERSION...$(tput sgr0)
        asdf install $TARGET_LANG $VERSION
        asdf set -u $TARGET_LANG $VERSION
        asdf reshim $TARGET_LANG
        ;;
      'terraform')
        VERSION=$(asdf latest $TARGET_LANG)
        echo $(tput setaf 2)Install $TARGET_LANG $VERSION...$(tput sgr0)
        asdf install $TARGET_LANG $VERSION
        asdf set -u $TARGET_LANG $VERSION
        asdf reshim $TARGET_LANG
        ;;
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
        asdf set -u $TARGET_TOOL stable
        ;;
    esac
  done

  # getprはHomebrewにもリリースバイナリにもないので、asdfで入れたgoからビルドする
  # bashから実行されasdfのshimsがPATHにない場合があるので、asdf exec経由で呼ぶ
  asdf exec go install github.com/skanehira/getpr@latest
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
