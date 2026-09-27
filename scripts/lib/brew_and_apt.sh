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

BREWFILE=~/dotfiles/scripts/lib/Brewfile

# Homebrew以外(公式サイトのdmgなど)で入れたアプリが既にあると、caskのインストールが「already an App at ...」で失敗する
# 既にあるアプリ・pkg・コマンドに対応するcaskを除いたBrewfileを標準出力に出す
filter_installed_casks() {
  local CASKS=$(brew bundle list --file=$BREWFILE --cask)
  local SKIP_CASKS=$(brew info --cask --json=v2 $CASKS | /usr/bin/python3 -c '
import json, os, shutil, subprocess, sys
pkgs = set(subprocess.run(["pkgutil", "--pkgs"], capture_output=True, text=True).stdout.split())
for cask in json.load(sys.stdin)["casks"]:
    found = False
    for artifact in cask["artifacts"]:
        for app in artifact.get("app", []):
            name = app if isinstance(app, str) else app.get("target", "")
            name = os.path.basename(name)
            found |= any(os.path.exists(os.path.join(d, name)) for d in ["/Applications", os.path.expanduser("~/Applications")])
        for binary in artifact.get("binary", []):
            name = binary if isinstance(binary, str) else binary.get("target", "")
            found |= shutil.which(os.path.basename(name)) is not None
        for uninstall in artifact.get("uninstall", []):
            ids = uninstall.get("pkgutil", []) if isinstance(uninstall, dict) else []
            found |= any(i in pkgs for i in ([ids] if isinstance(ids, str) else ids))
    if found:
        print(cask["token"])
')

  local LINE TOKEN
  while IFS= read -r LINE; do
    if [[ $LINE =~ ^cask\ \"([^\"]+)\" ]]; then
      TOKEN=${BASH_REMATCH[1]}
      if echo "$SKIP_CASKS" | grep -qx "$TOKEN"; then
        echo $(tput setaf 2)$TOKEN has been already installed. Skip.$(tput sgr0) >&2
        continue
      fi
    fi
    echo "$LINE"
  done < $BREWFILE
}

install_brew_packages() {
  check_brew

  if is_darwin; then
    echo $(tput setaf 2)brew bundle...$(tput sgr0)
    # mas行はApp Storeにサインインしていないと失敗するが、残りのパッケージは入れ切りたいので止めない
    local FILTERED_BREWFILE=$(mktemp)
    filter_installed_casks > $FILTERED_BREWFILE
    brew bundle --file=$FILTERED_BREWFILE || true
    rm -f $FILTERED_BREWFILE
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
