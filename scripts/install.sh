#!/bin/bash -ue

# STEP
# 1. check_dotfiles()
# 2. setup_tools()
#    - Setup brew
#    - Setup default shell
#    - Setup git-token.fish
#    - Setup asdf

has() {
  which $1 > /dev/null 2>&1
}

DOTFILES_DIR="$HOME/dotfiles"
DOT_TARBALL="https://github.com/uki1014/dotfiles/tarball/master"
DOT_REMOTE_URL="https://github.com/uki1014/dotfiles.git"

# macOSの/usr/bin/gitはCommand Line Tools未導入だとインストールダイアログを出して失敗するだけなので、実際に使えるかで判定する
can_use_git() {
  if [ "$(uname -s)" == 'Darwin' ]; then
    xcode-select -p > /dev/null 2>&1
  else
    has "git"
  fi
}

# gitを使えるようにするため、dotfilesを取得する前にCommand Line Toolsを入れる
# xcode-select --installはGUIのダイアログで完了を待てないので、Homebrewのインストーラと同じくsoftwareupdateで入れる
install_command_line_tools() {
  if [ "$(uname -s)" != 'Darwin' ] || xcode-select -p > /dev/null 2>&1; then
    return
  fi

  echo $(tput setaf 2)Installing Command Line Tools...$(tput sgr0)
  local PLACEHOLDER=/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  touch $PLACEHOLDER
  local LABEL=$(softwareupdate -l 2>/dev/null | grep -E '^\* Label: Command Line Tools' | sed -e 's/^\* Label: //' | sort -V | tail -n 1)
  if [ -n "$LABEL" ]; then
    sudo softwareupdate -i "$LABEL"
  fi
  rm -f $PLACEHOLDER

  if ! xcode-select -p > /dev/null 2>&1; then
    echo $(tput setaf 1)Failed to install Command Line Tools. Run xcode-select --install and try again.$(tput sgr0)
    exit 1
  fi
}

check_dotfiles() {
  # ディレクトリの有無だけで判定すると、取得に失敗して空のまま残ったディレクトリを「導入済み」と誤認する
  if [ -f $DOTFILES_DIR/scripts/install.sh ]; then
    echo $(tput setaf 2)Your dotfiles has been already installed.$(tput sgr0)
    return
  fi

  if [ -d $DOTFILES_DIR ] && [ -n "$(ls -A $DOTFILES_DIR)" ]; then
    echo $(tput setaf 1)$DOTFILES_DIR exists but is not a complete dotfiles. Move or remove it and run again.$(tput sgr0)
    exit 1
  fi
  rmdir $DOTFILES_DIR 2> /dev/null || true

  echo $(tput setaf 2)Downloading dotfiles...$(tput sgr0)
  if can_use_git; then
    git clone ${DOT_REMOTE_URL} ${DOTFILES_DIR}
  else
    mkdir $DOTFILES_DIR
    curl -fsSL ${DOT_TARBALL} | tar -zx --strip-components 1 -C ${DOTFILES_DIR}
  fi

  if [ ! -f $DOTFILES_DIR/scripts/install.sh ]; then
    echo $(tput setaf 1)Failed to download dotfiles.$(tput sgr0)
    exit 1
  fi
  echo $(tput setaf 2)Download dotfiles complete!. ✔︎$(tput sgr0)
  cd $DOTFILES_DIR
}

# dotfilesがない状態で実行するため、この行まではsourceができない
install_command_line_tools
check_dotfiles

source ~/dotfiles/scripts/lib/asdf.sh
source ~/dotfiles/scripts/lib/brew_and_apt.sh
source ~/dotfiles/scripts/lib/git.sh
source ~/dotfiles/scripts/utils/source_all_utils.sh

setup_default_shell() {
  local FISH_PATH=$(command -v fish || true)
  if [ -z "$FISH_PATH" ]; then
    echo $(tput setaf 1)fish is not installed. Skip changing default shell.$(tput sgr0)
    return
  fi

  # /etc/shellsに無いシェルはchshが拒否する
  if ! grep -qx "$FISH_PATH" /etc/shells; then
    echo "$FISH_PATH" | sudo tee -a /etc/shells > /dev/null
  fi

  # $SHELLはこのセッション開始時の値なので、登録されているログインシェルを直接見る
  if is_darwin; then
    local CURRENT_SHELL=$(dscl . -read /Users/$USER UserShell | awk '{print $2}')
  else
    local CURRENT_SHELL=$(getent passwd $USER | cut -d: -f7)
  fi

  if [ "$CURRENT_SHELL" != "$FISH_PATH" ]; then
    echo $(tput setaf 2)Change default shell to $FISH_PATH...$(tput sgr0)
    sudo chsh -s "$FISH_PATH" "$USER"
  else
    echo $(tput setaf 2)Default shell is already fish.$(tput sgr0)
  fi
}

setup_tools() {
  echo $(tput setaf 2)Setup tools...$(tput sgr0)

  # Setup Homebrew
  install_brew_packages

  setup_default_shell

  # Setup git-token.fish
  create_token_file

  # Setup asdf
  install_asdf

  echo $(tput setaf 2)Setup Tools complete!. ✔︎$(tput sgr0)
}

setup_macos_defaults() {
  if is_darwin; then
    bash ~/dotfiles/scripts/macos/defaults.sh
  fi
}

if [ $# == 0 ]; then
  setup_tools
  setup_symlink
  setup_macos_defaults
else
  case $1 in
    "link")
      echo $(tput setaf 2)✔︎ Link files...$(tput sgr0)
      setup_symlink
      ;;
    "tools")
      echo $(tput setaf 2)✔︎ Setup tools...$(tput sgr0)
      setup_tools
      ;;
    "shell")
      echo $(tput setaf 2)✔︎ Setup default shell...$(tput sgr0)
      setup_default_shell
      ;;
    "defaults")
      echo $(tput setaf 2)✔︎ Setup macOS defaults...$(tput sgr0)
      setup_macos_defaults
      ;;
  esac
fi

exit 0
