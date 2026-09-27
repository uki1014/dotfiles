#!/bin/bash -ue

DOTFILES_DIR=$HOME/dotfiles
SCRIPTS_DIR=$DOTFILES_DIR/scripts

# $HOMEにおきたいdotfiles
TARGET_DOTFILES=(
  .bashrc
  .zshrc
  .tmux.conf
  .agignore
  .rgignore
  .gitconfig
  .gitignore_global
  .hyper.js
)

# $HOME/.configにおきたいdotfiles dirctory
TARGET_CONFIG_DIRS=(
  fish
  bat
  nvim
  ghostty
  karabiner
)

# $HOME/.config以下に個別に置きたいファイル
# ディレクトリごとリンクするとherdrのsocketやlogまでリポジトリ側に入るため1ファイルずつ張る
TARGET_CONFIG_FILES=(
  herdr/config.toml
  herdr/sounds
)

# works/は仕事用の設定置き場で、同名の.gitconfigなどが見つかって個人用と取り違えるので除外する
get_target_dotfiles_path() {
  find $DOTFILES_DIR -type f \
    -name "$1" \
    -not -path "*/undo/*" \
    -not -path "$DOTFILES_DIR/works/*" \
    -not -path "$DOTFILES_DIR/.git/*"
}

get_target_config_dir() {
  find $DOTFILES_DIR -type d \
    -name "$1" \
    -not -path "*/undo/*" \
    -not -path "$DOTFILES_DIR/works/*" \
    -not -path "$DOTFILES_DIR/.git/*"
}

create_dotbackup() {
  BACKUP_PATH=$1
  if [ ! -d $BACKUP_PATH ]; then
    echo $(tput setaf 2)Create $BACKUP_PATH directory for backup old dotfiles...$(tput sgr0)
    mkdir -p $BACKUP_PATH
  else
    echo $(tput setaf 2)$BACKUP_PATH is already created.$(tput sgr0)
  fi
}

# リンクを張る場所に既存のファイルがあれば退避する。symlinkは張り直すだけなので消す
create_backup() {
  LINK_PATH=$1 # Ex. $HOME/.bashrc, $HOME/.config/fish
  BACKUP_PATH=$2 # Ex. ~/dotbackup or ~/dotbackup/.config

  if [ -L "$LINK_PATH" ]; then
    rm "$LINK_PATH"
  elif [ -e "$LINK_PATH" ]; then
    local NAME=`basename "$LINK_PATH"`
    # 前回のバックアップを上書きしないよう、既にあれば日時を付ける
    local DEST="$BACKUP_PATH/$NAME"
    if [ -e "$DEST" ]; then
      DEST="$DEST.`date +%Y%m%d%H%M%S`"
    fi
    echo $(tput setaf 2)Move $LINK_PATH to $DEST...$(tput sgr0)
    mv "$LINK_PATH" "$DEST"
  fi
}

# 見つからない・複数見つかった場合にlnへそのまま渡すと、$HOME自体を上書きしようとして失敗する
link_one() {
  TARGET_PATH=$1
  LINK_PATH=$2
  BACKUP_PATH=$3

  if [ -z "$TARGET_PATH" ]; then
    echo $(tput setaf 1)`basename "$LINK_PATH"` is not found in dotfiles. Skipped.$(tput sgr0)
    return
  fi
  if [ `echo "$TARGET_PATH" | wc -l` -ne 1 ]; then
    echo $(tput setaf 1)`basename "$LINK_PATH"` is found in multiple places. Skipped.$(tput sgr0)
    echo "$TARGET_PATH"
    return
  fi

  create_backup "$LINK_PATH" "$BACKUP_PATH"
  echo $(tput setaf 2)Put "$LINK_PATH" symbolic link ...$(tput sgr0)
  ln -sn "$TARGET_PATH" "$LINK_PATH"
}

link_to_root() {
  BACKUP_PATH="$HOME/dotbackup"
  create_dotbackup $BACKUP_PATH

  if [ $HOME != $DOTFILES_DIR ]; then
    echo $(tput setaf 2)Start setup symbolic link...$(tput sgr0)

    # Ex. TARGET_DOTFILE: .bashrc
    for TARGET_DOTFILE in ${TARGET_DOTFILES[@]}; do
      link_one "`get_target_dotfiles_path $TARGET_DOTFILE`" "$HOME/$TARGET_DOTFILE" $BACKUP_PATH
    done
  else
    echo "HOME == DOTFILES_DIR. You should change DOTFIELS_DIR."
  fi
}

link_to_config_dir() {
  BACKUP_PATH="$HOME/dotbackup/.config"
  create_dotbackup $BACKUP_PATH
  mkdir -p $HOME/.config

  if [ $HOME != $DOTFILES_DIR ]; then
    # Ex. TARGET_CONFIG_DIR: fish
    for TARGET_CONFIG_DIR in ${TARGET_CONFIG_DIRS[@]}; do
      link_one "`get_target_config_dir $TARGET_CONFIG_DIR`" "$HOME/.config/$TARGET_CONFIG_DIR" $BACKUP_PATH
    done
  else
    echo $(tput setaf 2)HOME == DOTFILES_DIR. You should change DOTFIELS_DIR.$(tput sgr0)
  fi
}

link_to_config_file() {
  BACKUP_PATH="$HOME/dotbackup/.config"
  create_dotbackup $BACKUP_PATH

  if [ $HOME != $DOTFILES_DIR ]; then
    # Ex. TARGET_CONFIG_FILE: herdr/config.toml
    for TARGET_CONFIG_FILE in ${TARGET_CONFIG_FILES[@]}; do
      TARGET_PATH="$DOTFILES_DIR/$TARGET_CONFIG_FILE"
      LINK_PATH="$HOME/.config/$TARGET_CONFIG_FILE"

      mkdir -p "`dirname $LINK_PATH`"

      if [ -f "$LINK_PATH" ] && [ ! -L "$LINK_PATH" ]; then
        if [ -e "$BACKUP_PATH/$TARGET_CONFIG_FILE" ]; then
          echo $(tput setaf 2)The target backup was founded and make a backup...$(tput sgr0)
          rm -f "$LINK_PATH"
        else
          echo $(tput setaf 2)The target file was founded and make a backup...$(tput sgr0)
          mkdir -p "`dirname $BACKUP_PATH/$TARGET_CONFIG_FILE`"
          mv "$LINK_PATH" "$BACKUP_PATH/$TARGET_CONFIG_FILE"
        fi
      fi

      if [ -L "$LINK_PATH" ]; then
        unlink "$LINK_PATH"
      fi

      # 実体のディレクトリが居座っているとln -snfが中に潜り込むので触らない
      if [ -d "$LINK_PATH" ]; then
        echo $(tput setaf 1)$LINK_PATH is a real directory. Skipped.$(tput sgr0)
        continue
      fi

      echo $(tput setaf 2)Put "~/.config/$TARGET_CONFIG_FILE" symbolic link ...$(tput sgr0)
      ln -snf "$TARGET_PATH" "$LINK_PATH"
    done
  else
    echo $(tput setaf 2)HOME == DOTFILES_DIR. You should change DOTFIELS_DIR.$(tput sgr0)
  fi
}

setup_symlink() {
  link_to_root
  link_to_config_dir
  link_to_config_file
  echo $(tput setaf 2)Setup symbolic links complete!. ✔︎$(tput sgr0)
}

# If you want to run, pass something as an argument
if [ $# != 0 ]; then
  setup_symlink
fi
