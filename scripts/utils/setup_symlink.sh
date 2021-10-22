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
)

get_target_dotfiles_path() {
  find $DOTFILES_DIR -type f \
    -name "$1" \
    -not -path "undo/*"
}

get_target_config_dir() {
  find $DOTFILES_DIR -type d \
    -name "$1" \
    -not -path "undo/*"
}

create_dotbackup() {
  BACKUP_PATH=$1
  echo $BACKUP_PATH
  if [ ! -d $BACKUP_PATH ]; then
    echo "Create $BACKUP_PATH directory for backup old dotfiles..."
    mkdir $BACKUP_PATH
  else
    echo "$BACKUP_PATH is already created."
  fi
}

create_backup() {
  DOTFILE_PATH=$1 # ファイルを配置したいPATH Ex. $HOME/.config
  TARGET_DOTFILE_OR_DIR_NAME=$2 # Ex. .bashrc, fish/
  BACKUP_PATH=$3 # Ex. ~/dotbackup or ~/dotbackup/.config

  # ディレクトリがすでに存在する場合はbackup
  if [ -e "$DOTFILE_PATH/$TARGET_DOTFILE_OR_DIR_NAME" ]; then
    # backupがすでにある場合はそのままにする
    if [ -e "$BACKUP_PATH/$TARGET_DOTFILE_OR_DIR_NAME" ]; then
      echo "The target backup was founded and make a backup..."
      rm -rf "$HOME/.config/$TARGET_DOTFILE_OR_DIR_NAME"
    else
      echo "The target directory was founded and make a backup..."
      echo $HOME/.config/$TARGET_DOTFILE_OR_DIR_NAME
      mv "$DOTFILE_PATH/$TARGET_DOTFILE_OR_DIR_NAME" $BACKUP_PATH
    fi
  fi
}

check_and_unlink() {
  TARGET_PATH=$1
  # Symリンクがすでに存在していた場合はunlink
  if [ -L "$TARGET_PATH" ]; then
    echo "Already exists $TARGET_DOTFILE symbolic link..."
    unlink "$TARGET_PATH"
  fi
}

link_to_root() {
  BACKUP_PATH="$HOME/dotbackup"
  create_dotbackup $BACKUP_PATH

  if [ $HOME != $DOTFILES_DIR ]; then
    echo "Start setup symbolic link..."

    # Ex. TARGET_DOTFILE: .bashrc
    for TARGET_DOTFILE in ${TARGET_DOTFILES[@]}; do
      # Ex. TARGET_PATH: /Users/username/.bashrc
      TARGET_PATH=`get_target_dotfiles_path $TARGET_DOTFILE`

      create_backup "$HOME" $TARGET_DOTFILE $BACKUP_PATH
      check_and_unlink $TARGET_PATH

      echo "Put "~/$TARGET_DOTFILE" symbolic link ..."
      ln -snf $TARGET_PATH $HOME
    done
  else
    echo "HOME == DOTFILES_DIR. You should change DOTFIELS_DIR."
  fi
}

link_to_config_dir() {
  BACKUP_PATH="$HOME/dotbackup/.config"
  create_dotbackup $BACKUP_PATH

  if [ $HOME != $DOTFILES_DIR ]; then
    # Ex. TARGET_CONFIG_DIR: fish
    for TARGET_CONFIG_DIR in ${TARGET_CONFIG_DIRS[@]}; do
      # Ex. TARGET_PATH: /Users/username/dotfiles/shell/fish
      TARGET_PATH=`get_target_config_dir $TARGET_CONFIG_DIR`

      create_backup "$HOME/.config" $TARGET_CONFIG_DIR $BACKUP_PATH
      check_and_unlink $TARGET_PATH

      echo "Put "~/.config/$TARGET_DOTFILE" symbolic link ..."
      ln -snf $TARGET_PATH $HOME/.config
    done
  else
    echo "HOME == DOTFILES_DIR. You should change DOTFIELS_DIR."
  fi
}


setup_symlink() {
  link_to_root
  link_to_config_dir
  echo $(tput setaf 2)Setup symbolic links complete!. ✔︎$(tput sgr0)
}

# If you want to run, pass something as an argument
[ ! $# == 0 ] && setup_symlink
