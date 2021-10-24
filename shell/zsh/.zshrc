export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8

if [ -d ~/dotfiles/freee ]; then
  echo 'source freee.zsh!'
  source ~/dotfiles/freee/freee.zsh
fi

if [ -e $DOTFILES_PATH/shell/alias.sh ]; then
  source $DOTFILES_PATH/shell/alias.sh
fi

# fishを読み込まない時はtmuxの起動確認と秘密鍵の読み込み
if [[ ! -n $TMUX && $- == *l* ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | $PERCOL | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi
