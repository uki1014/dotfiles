# dotfiles

[![Setup my dotfiles for Linux](https://github.com/uki1014/dotfiles/actions/workflows/linux-os.yml/badge.svg)](https://github.com/uki1014/dotfiles/actions/workflows/linux-os.yml)
[![Setup my dotfiles for macOS](https://github.com/uki1014/dotfiles/actions/workflows/mac-os.yml/badge.svg)](https://github.com/uki1014/dotfiles/actions/workflows/mac-os.yml)

## Install In One Command

```sh
bash <(curl -s https://raw.githubusercontent.com/uki1014/dotfiles/master/scripts/install.sh)
```

## Supported OS

- Linux (ubuntu recommended)
- macOS

## Main Tools

- neovim
- tmux
- homebrew
- asdf
- fish

## Install Languages

- Ruby
- Node.js
- Golang
- Python
- Terraform

## Setup a new Mac

1. `xcode-select --install` を実行し、`sudo xcodebuild -license accept` でライセンスに同意する
2. App Store にサインインする（Brewfile の `mas` 行に必要）
3. 上の Install In One Command を実行する。Homebrew・[`Brewfile`](scripts/lib/Brewfile) のパッケージとアプリ・symlink がまとめて入る
4. macOS の設定（キーボード・トラックパッド・Dock・Finder など）は手順 3 で [`defaults.sh`](scripts/macos/defaults.sh) が反映されるので、一度ログアウトする
5. Node.js を asdf で入れたあと、`brew bundle --file=~/dotfiles/scripts/lib/Brewfile` を再実行する（`npm` 行が入る）

アプリやパッケージを追加したら、今の Mac で次を実行して Brewfile を更新する。dump は既存の内容を上書きするので、出力後に不要な行を削ってからコミットする。

```sh
brew bundle dump --file=~/dotfiles/scripts/lib/Brewfile --force
```

## Homebrew & Apt packages

- macOS: [`scripts/lib/Brewfile`](scripts/lib/Brewfile)
- Linux: [`scripts/lib/brew_and_apt.sh`](scripts/lib/brew_and_apt.sh)
