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
  if [ ! -d "$HOME/$BACKUP_PATH" ]; then
    echo "Create ~/$BACKUP_PATH directory for backup old dotfiles..."
    mkdir ~/$BACKUP_PATH
  else
    echo "$BACKUP_PATH is already created."
  fi
}

is_dotfile_exist() {
  TARGET_DOTFILE=$1
  [ -e "$HOME/`basename $TARGET_DOTFILE`" ] > /dev/null 2>&1
}

is_dotbackup_exist() {
  TARGET_DOTFILE=$1
  [ -e "$HOME/dotbackup/`basename $TARGET_DOTFILE`" ] > /dev/null 2>&1
}

link_to_root() {
  create_dotbackup 'dotbackup'

  if [ $HOME != $DOTFILES_DIR ]; then
    echo "Start setup symbolic link..."

    for TARGET_DOTFILE in ${TARGET_DOTFILES[@]}; do
      TARGET_PATH=`get_target_dotfiles_path $TARGET_DOTFILE`

      # ファイルがすでに存在する場合はbackup
      if is_dotfile_exist; then
        # backupがすでにある場合はそのままにする
        if is_dotbackup_exist $TARGET_DOTFILE; then
          rm -rf "$HOME/`basename $TARGET_DOTFILE`"
        else
          echo "The target file was founded and make a backup..."
          echo $HOME/`basename $TARGET_DOTFILE`
          mv "$HOME/`basename $TARGET_DOTFILE`" "$HOME/dotbackup"
        fi
      fi

      # Symリンクがすでに存在していた場合はunlink
      if [ -L "$HOME/`basename $TARGET_DOTFILE`" ]; then
        echo "Already exists $TARGET_DOTFILE symbolic link..."
        unlink "$HOME/`basename $TARGET_DOTFILE`"
      fi

      echo "Put "$TARGET_DOTFILE" symbolic link ..."
      ln -snf $TARGET_PATH $HOME
    done
  else
    echo "HOME == DOTFILES_DIR. You should change DOTFIELS_DIR."
  fi
}

link_to_config_dir() {
  create_dotbackup 'dotbackup/.config'

  if [ $HOME != $DOTFILES_DIR ]; then
    for TARGET_CONFIG_DIR in ${TARGET_CONFIG_DIRS[@]}; do
      TARGET_PATH=`get_target_config_dir $TARGET_CONFIG_DIR`

      # ディレクトリがすでに存在する場合はbackup
      if [ -d "$HOME/.config/`basename $TARGET_CONFIG_DIR`" ]; then
        if [ -d "$HOME/dotbackup/.config/`basename $TARGET_CONFIG_DIR`" ]; then
          rm -rf "$HOME/.config/`basename $TARGET_CONFIG_DIR`"
        else
          echo "The target directory was founded and make a backup..."
          echo $HOME/.config/`basename $TARGET_CONFIG_DIR`
          mv "$HOME/.config/`basename $TARGET_CONFIG_DIR`" "$HOME/dotbackup/.config"
        fi
      fi

      # Symリンクがすでに存在していた場合はunlink
      if [ -L "$HOME/.config/`basename TARGET_CONFIG_DIR`" ]; then
        echo "Already exists TARGET_CONFIG_DIR symbolic link"
        unlink "$HOME/.config/`basename TARGET_CONFIG_DIR`"
      fi

      ln -snf $TARGET_PATH $HOME/.config
    done
  else
    echo "HOME == DOTFILES_DIR. You should change DOTFIELS_DIR."
  fi
}


main() {
  link_to_root
  link_to_config_dir
}

# If you want to run, pass something as an argument
[ ! $# == 0 ] && main
