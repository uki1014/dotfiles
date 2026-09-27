#!/bin/bash -u

source ~/dotfiles/scripts/utils/source_all_utils.sh

# Linux向けCUI tools（macOSはBrewfileで管理）
target_brew_list=(
  ripgrep
  peco
  tmux
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
  tree-sitter
  tree-sitter-cli
  luajit
  gpg
  fd
  neofetch
  mycli
  shellcheck
  hadolint
  xauth # x11でclipboard共有の時に必要
  bottom
)

install_brew_packages() {
  check_brew

  if is_darwin; then
    echo $(tput setaf 2)brew bundle...$(tput sgr0)
    # mas行はApp Storeにサインインしていないと失敗するが、残りのパッケージは入れ切りたいので止めない
    brew bundle --file=~/dotfiles/scripts/lib/Brewfile || true
    # Brewfileのmasで入るXcodeはライセンスに同意しないとbrewやgitが止まる
    if [ -d /Applications/Xcode.app ]; then
      sudo xcodebuild -license accept
    fi
    return
  fi

  for target in ${target_brew_list[@]}; do
    if ! has "$target"; then
      brew install $target
    else
      echo $(tput setaf 2)$target has been already installed.$(tput sgr0)
    fi
  done
}

if [ $# != 0 ]; then
  install_brew_packages
fi
