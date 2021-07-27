#!/usr/bin/env bash

set -ue

script_dir="$(cd "$(dirname "$BASH_SOURCE[0]")" && pwd -P)"
dot_dir=$(dirname ${script_dir})
dot_config_dir="$HOME/.config"
# $HOMEにおきたいdotfiles
target_dotfiles=(
  .zshrc
  .bashrc
  .tmux.conf
  .agignore
  .rgignore
  .gitconfig
  .gitignore_global
  .hyper.js
)
# $HOME/.configにおきたいdotfiles dirctory
target_config_dir=(
  fish
  bat
  nvim
)

function help_message() {
  echo "Usage: $0 [--help | h]" 0>&2
  echo ""
}

function get_target_dotfiles_path() {
  find $dot_dir -type f \
    -name "$1" \
    -not -name "lightline" \
    -not -name "maps" \
    -not -path "undo/*"
}

function get_target_config_dir() {
  find $dot_dir -type d \
    -name "$1" \
    -not -path "undo/*"
}

function link_to_root() {
  if [ ! -d "$HOME/dotbackup" ]; then
    echo "Create ~/dotbackup for backup old dotfiles..."
    echo "$HOME/dotbackup not found. Auto make it."
    mkdir "$HOME/dotbackup"
  fi

  if [[ "$HOME" != "$dot_dir" ]]; then

    echo "******start setup symbolic link...******"

    for f in ${target_dotfiles[@]}; do
      target_path=`get_target_dotfiles_path $f`

      # ファイルがすでに存在する場合はbackup
      if [[ -e "$HOME/`basename $f`" ]]; then
        if [[ -e "$HOME/dotbackup/`basename $f`"  ]]; then
          rm -rf "$HOME/`basename $f`"
        else
          echo "******The target file was founded and make a backup...******"
          echo $HOME/`basename $f`
          mv "$HOME/`basename $f`" "$HOME/dotbackup"
        fi
      fi

      # Symリンクがすでに存在していた場合はunlink
      if [[ -L "$HOME/`basename $f`" ]]; then
        echo "******Already exists $f symbolic link******"
        unlink "$HOME/`basename $f`"
      fi

      echo "******Put "$f" symbolic link ...******"
      ln -snf $target_path $HOME
    done
  else
    echo "HOME == dot_dir"
  fi
}

function link_to_config_dir() {
  if [ ! -d "$HOME/dotbackup/.config" ]; then
    echo "Create ~/dotbackup/config for backup old .config..."
    echo "$HOME/dotbackup/.config not found. Auto make it."
    mkdir -p "$HOME/dotbackup/.config"
  fi

  if [[ "$HOME" != "$dot_dir" ]]; then

    for f in ${target_config_dir[@]}; do
      target_path=`get_target_config_dir $f`

      # ディレクトリがすでに存在する場合はbackup
      if [[ -d "$HOME/.config/`basename $f`" ]]; then
        if [[ -d "$HOME/dotbackup/.config/`basename $f`"  ]]; then
          rm -rf "$HOME/.config/`basename $f`"
        else
          echo "******The target directory was founded and make a backup...******"
          echo $HOME/.config/`basename $f`
          mv "$HOME/.config/`basename $f`" "$HOME/dotbackup/.config"
        fi
      fi

      # Symリンクがすでに存在していた場合はunlink
      if [[ -L "$HOME/.config/`basename $f`" ]]; then
        echo "******Already exists $f symbolic link******"
        unlink "$HOME/.config/`basename $f`"
      fi

      ln -snf $target_path $HOME/.config
    done
  else
    echo "HOME == dot_dir"
  fi
}


function main() {
  while [ $# -gt 0 ];do
    case ${1} in
      --debug|-d)
        set -uex
        ;;
      --help|-h)
        help_message
        exit 1
        ;;
      *)
        ;;
    esac
    shift
  done

  link_to_root
  link_to_config_dir
}

main
