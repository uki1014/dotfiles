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
set -g fish_user_paths "/usr/local/opt/openssl@1.1/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

if [ -e $DOTFILES_PATH/git/token.fish ]
  source $DOTFILES_PATH/git/token.fish
end

# fish vi-mode
fish_vi_key_bindings

if status --is-interactive
  # macOSとLinuxそれぞれの設定
  if is_darwin
    source /usr/local/opt/asdf/libexec/asdf.fish

    alias sa='ssh-add -K ~/.ssh/id_rsa'
    if [ $SHLVL = 1 ]
      sa
    end

    # coreutils
    set -xg PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
    set -xg MANPATH /usr/local/opt/coreutils/libexec/gnuman $MANPATH
    # findutils
    set -xg PATH /usr/local/opt/findutils/libexec/gnubin $PATH
    set -xg MANPATH /usr/local/opt/findutils/libexec/gnuman $MANPATH
    # gnu-sed
    set -xg PATH /usr/local/opt/gnu-sed/libexec/gnubin $PATH
    set -xg MANPATH /usr/local/opt/gnu-sed/libexec/gnuman $MANPATH
    # grep
    set -xg PATH /usr/local/opt/grep/libexec/gnubin $PATH
    set -xg MANPATH /usr/local/opt/grep/libexec/gnuman $MANPATH
    # awk
    alias awk='gawk'
    # tar
    set -xg PATH /usr/local/opt/gnu-tar/libexec/gnubin $PATH
    set -xg MANPATH /usr/local/opt/gnu-tar/libexec/gnuman $MANPATH

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
  eval (direnv hook fish)
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

# 下に4つのpaneをつくる
function idef
  tmux split-window -v -p 21
  tmux split-window -h -p 75
  tmux split-window -h -p 66
  tmux split-window -h -p 50
end

# 下に2つのpaneを作る
function idet
  tmux split-window -v -p 21
  tmux split-window -h -p 50
end

function chilide
  # dotfiles
  tmux rename-window dotfiles
  chils

  # chillers-server
  tmux new-window
  tmux rename-window chill-server
  ide
  chilf

  # chillers-frontend
  tmux new-window
  tmux rename-window chill-frontend
  ide

  # 順番にやるとおかしくなるので最後にdotfilesに移動
  tmux next-window
  cdd
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

function update_nvim
  if not [ -d ~/nvim_backup ]
    mkdir ~/nvim_backup
  end

  if is_darwin
    cd
    sudo mv ~/nvim ~/nvim_backup/nvim-(date '+%Y-%m-%d_%H:%M:%S')
    curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
    tar xzf ~/nvim-macos.tar.gz
    sudo rm -f ~/nvim-macos.tar.gz
    mv nvim-osx64 nvim
  else if is_linux
    cd
    sudo mv /usr/local/bin/nvim ~/nvim_backup/nvim-(date '+%Y-%m-%d_%H:%M:%S')
    curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
    chmod u+x ~/nvim.appimage
    sudo mv ~/nvim.appimage ~/nvim
    sudo mv ~/nvim /usr/local/bin
  end
end

function restore_nvim
  cd ~/nvim_backup
  if is_darwin
    sudo rm -rf ~/nvim
    mv (ls -c | head -n 3 | awk 'END{print $1}') ~/nvim
  else if is_linux
    sudo rm -rf /usr/local/bin/nvim
    mv (ls -c | head -n 3 | awk 'END{print $1}') /usr/local/bin
  end
  cd
end

function update_nvim_v5
  if is_darwin
    cd
    sudo rm -rf ~/nvim-osx64
    curl -LO https://github.com/neovim/neovim/releases/download/v0.5.0/nvim-macos.tar.gz
    tar xzf ~/nvim-macos.tar.gz
    sudo rm -f ~/nvim-macos.tar.gz
  else if is_linux
    cd
    sudo rm ~/nvim.appimage
    curl -LO https://github.com/neovim/neovim/releases/download/v0.5.0/nvim.appimage
    chmod u+x nvim.appimage
    sudo mv ~/nvim.appimage ~/nvim
    sudo mv ~/nvim /usr/local/bin
  end
end

# Install fisher
if not functions -q fisher
  set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
  curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
  fish -c fisher
end

function fl
  fzf --preview 'bat --style=numbers --color=always --theme="Solarized (light)" --line-range :500 {}'
end

function cat
  bat --style=numbers --color=always --theme="Solarized (light)" --line-range :500 $argv
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

# neovimのpython2と3の環境でpip-packagesのupdate
function update_pyneovim_pyenv
  pyenv activate neovim2
  pip install --upgrade pip
  pip install --upgrade pynvim
  pyenv deactivate neovim2
  pyenv activate neovim3
  pip install --upgrade pip
  pip install --upgrade pynvim
  pyenv deactivate neovim3
end

function update_pyneovim
  pip2 install --upgrade pip
  pip2 install --upgrade pynvim
  pip3 install --upgrade pip
  pip3 install --upgrade pynvim
end

if [ -e $DOTFILES_PATH/shell/alias.sh ]
  source $DOTFILES_PATH/shell/alias.sh
end

if [ -d $DOTFILES_PATH/freee ]
  source $DOTFILES_PATH/freee/freee.config.fish
end
