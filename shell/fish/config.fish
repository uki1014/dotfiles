function attach_tmux_session_if_needed
  if [ -z $TMUX ]
    set ID (tmux list-sessions)
    if [ -z "$ID" ]
      tmux new-session
      return
    end

    set new_session "Create New Session"
    set ID (echo $ID\n$new_session | peco --on-cancel=error | cut -d: -f1)
    if [ "$ID" = "$new_session" ]
      tmux new-session
    else if [ -n "$ID" ]
      tmux attach-session -t "$ID"
    end
  end
end

function is_darwin
  [ (uname) = 'Darwin' ] > /dev/null 2>&1
end

function is_linux
  [ (uname) = 'Linux' ] > /dev/null 2>&1
end

if test (uname) = 'Darwin' && test (uname -m) = 'arm64' > /dev/null 2>&1
  set -xg HOMEBREW_PATH "/opt/homebrew"
  set -xg PATH /opt/homebrew/bin $PATH
  set -xg PATH /opt/homebrew/sbin $PATH
  eval (/opt/homebrew/bin/brew shellenv)

  set -xg RUBY_CFLAGS "-Wno-error=implicit-function-declaration"
  set -xg RUBY_CONFIGURE_OPTS "--with-openssl-dir=/opt/homebrew/opt/openssl@1.1"
  set -xg LDFLAGS "-L/opt/homebrew/opt/readline/lib"
  set -xg CPPFLAGS "-I/opt/homebrew/opt/readline/include"
  set -xg PKG_CONFIG_PATH "/opt/homebrew/opt/readline/lib/pkgconfig"
  set -xg optflags "-Wno-error=implicit-function-declaration"
  set -xg LDFLAGS "-L/opt/homebrew/opt/libffi/lib"
  set -xg CPPFLAGS "-I/opt/homebrew/opt/libffi/include"
  set -xg PKG_CONFIG_PATH "/opt/homebrew/opt/libffi/lib/pkgconfig"
else if test (uname) = 'Darwin' && test (uname -m) = 'x86_64' > /dev/null 2>&1
  set -xg HOMEBREW_PATH "/usr/local"
end

set -xg LC_CTYPE en_US.UTF-8
set -xg LC_ALL en_US.UTF-8
set -xg LANG en_US.UTF-8
set -xg PATH $PATH $HOME
set -xg DOTFILES_PATH $HOME/dotfiles
set -xg EDITOR nvim
set -xg TERM screen-256color
set -xg OSTYPE darwin20
set -xg DOCKER_BUILDKIT 1
set -xg DOCKER_HOST_NAME 172.17.0.1
set -xg GHQ_SELECTOR peco
set -xg theme_date_format "+%Y-%m-%d %H:%M:%S"
set -g fish_prompt_pwd_dir_length 0
set -g fish_user_paths "$HOMEBRW_PATH/opt/openssl@1.1/bin" $fish_user_paths
set -g fish_user_paths "$HOMEBRW_PATH/sbin" $fish_user_paths

if [ -e $DOTFILES_PATH/git/token.fish ]
  source $DOTFILES_PATH/git/token.fish
end

# fish vi-mode
fish_vi_key_bindings

if status --is-interactive
  # macOSとLinuxそれぞれの設定
  if is_darwin
    source $HOMEBREW_PATH/opt/asdf/libexec/asdf.fish

    alias sa='ssh-add --apple-use-keychain'
    if [ $SHLVL = 1 ]
      sa
    end

    # coreutils
    set -xg PATH $HOMEBREW_PATH/opt/coreutils/libexec/gnubin $PATH
    set -xg MANPATH $HOMEBREW_PATH/opt/coreutils/libexec/gnuman $MANPATH
    # findutils
    set -xg PATH $HOMEBREW_PATH/opt/findutils/libexec/gnubin $PATH
    set -xg MANPATH $HOMEBREW_PATH/opt/findutils/libexec/gnuman $MANPATH
    # gnu-sed
    set -xg PATH $HOMEBREW_PATH/opt/gnu-sed/libexec/gnubin $PATH
    set -xg MANPATH $HOMEBREW_PATH/opt/gnu-sed/libexec/gnuman $MANPATH
    # grep
    set -xg PATH $HOMEBREW_PATH/opt/grep/libexec/gnubin $PATH
    set -xg MANPATH $HOMEBREW_PATH/opt/grep/libexec/gnuman $MANPATH
    # awk
    alias awk='gawk'
    # tar
    set -xg PATH $HOMEBREW_PATH/opt/gnu-tar/libexec/gnubin $PATH
    set -xg MANPATH $HOMEBREW_PATH/opt/gnu-tar/libexec/gnuman $MANPATH

  else if is_linux
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    source /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.fish
    alias sa='ssh-add'

    if [ $SHLVL = 1 ]
      eval (ssh-agent -c)
      ssh-add
    end
  end

  attach_tmux_session_if_needed

  # direnv
  direnv hook fish | source

  # Go
  set -x GOPATH $HOME/go
  set -xg PATH $GOPATH/bin $PATH
end

# Dockerコンテナのシェルアクセスをfzfで簡単にする
function docker-exec
  set NAME (docker ps --format "{{.Names}}" | fzf)
  docker exec -it $NAME $argv
end

function ide
  tmux split-window -v -p 21
  tmux split-window -h -p 66
  tmux split-window -h -p 50
end

# 下に2つのpaneを作る
function idet
  tmux split-window -v -p 21
  tmux split-window -h -p 50
end

function drawide
  # dotfiles
  tmux rename-window dotfiles
  cd ~/program/projects/draw-server

  # draw-server
  tmux new-window
  tmux rename-window draw-server
  idet
  cd ~/program/projects/draw-web

  # draw-web
  tmux new-window
  tmux rename-window draw-web
  idet
  cd ~/program/projects/draw-desktop

  # draw-desktop
  tmux new-window
  tmux rename-window draw-desktop
  idet

  # 順番にやるとおかしくなるので最後にdotfilesに移動
  tmux next-window
  cdd
  clear
end

# rails/npm/resque/gitなどeditor以外のpane
function cide
  # 右下のpaneも縦に分割するパターン
  # tmux split-window -h -p 50
  # tmux split-window -v -p 50
  # tmux split-window -h -p 50
  # tmux select-pane -t :.-
  # tmux select-pane -t :.-
  # tmux split-window -h -p 50

  # 右下のpaneは分割しないパターン
  tmux split-window -h -p 50
  tmux split-window -v -p 50
  tmux select-pane -t :.+
  tmux select-pane -t :.+
  tmux split-window -h -p 50
end

# Install fisher
if not functions -q fisher
  set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
  curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
  fish -c fisher
end

function fl
  fzf --preview 'bat --style=numbers --color=always --theme="Visual Studio Dark+" --line-range :500 {}'
end

function cat
  bat --style=numbers --color=always --theme="Visual Studio Dark+" --line-range :500 $argv
end

function unset
  set --erase $argv
end

# fzf settings
set -U FZF_LEGACY_KEYBINDINGS 0

function cmm
  git add .
  git status
  git diff --staged
  git commit -m "$argv"
end

function cmmno
  git add .
  git status
  git diff --staged
  git commit -m "$argv" --no-verify
end

function cm
  git commit -m "$argv"
end

function cmno
  git commit -m "$argv" --no-verify
end

function update_pyneovim
  pip2 install --upgrade pip
  pip2 install --upgrade pynvim
  pip3 install --upgrade pip
  pip3 install --upgrade pynvim
end

function diary
  tmux new-window
  tmux rename-window diary
  cd ~/diary
end

if [ -e $DOTFILES_PATH/shell/alias.sh ]
  source $DOTFILES_PATH/shell/alias.sh
end

if [ -d $DOTFILES_PATH/freee ]
  source $DOTFILES_PATH/freee/freee.config.fish
end
