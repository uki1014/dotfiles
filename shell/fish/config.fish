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

if [ -e $DOTFILES_PATH/git/token.fish ]
  source $DOTFILES_PATH/git/token.fish
end

# fish vi-mode
fish_vi_key_bindings

if status --is-interactive
  # macOSとLinuxそれぞれの設定
  if test (uname) = 'Darwin'
    set -xg PATH $HOME/nvim-osx64/bin $PATH
    alias sa='ssh-add -K ~/.ssh/id_rsa'
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
  else if test (uname) = 'Linux'
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    source ~/.asdf/asdf.fish
    alias sa='ssh-add'

    if test $SHLVL = 1
      eval (ssh-agent -c)
      ssh-add
    end
  end

  # anyenv
  set -xg ANYENV_ROOT ~/.anyenv
  set -xg PATH $HOME/.anyenv/bin $PATH
  # anyenv init - fish | source

  # nodenv
  set -xg NODENV_ROOT $ANYENV_ROOT/envs/nodenv
  set -xg PATH $NODENV_ROOT/bin $NODENV_ROOT/shims $PATH

  # rbenv
  set -xg RBENV_ROOT $ANYENV_ROOT/envs/rbenv
  set -xg PATH $RBENV_ROOT/bin $RBENV_ROOT/shims $PATH

  # pyenv
  set -xg PYENV_ROOT $ANYENV_ROOT/envs/pyenv
  set -xg PATH $PYENV_ROOT/bin $PYENV_ROOT/shims $PATH
  status is-login; and pyenv init --path fish | source
  pyenv init - fish | source
  # pyenv-virtualenv
  pyenv virtualenv-init - fish | source

  # goenv
  set -xg GOENV_ROOT $ANYENV_ROOT/envs/goenv
  set -xg PATH $GOENV_ROOT/bin $GOENV_ROOT/shims $PATH
  set -xg GOPATH "$HOME/go"
  set -xg GO111MODULE on

  # tfenv
  set -xg TFENV_ROOT $ANYENV_ROOT/envs/tfenv
  set -xg PATH $TFENV_ROOT/bin $TFENV_ROOT/shims $PATH

  # direnv
  eval (direnv hook fish)
end

# function ssh
#   # tmux起動時
#   if [[ -e printenv TMUX ]]
#       # 現在のペインIDを記録
#       set pane_id=(tmux display -p '#{pane_id}')
#       # 接続先ホスト名に応じて背景色を切り替え
#       if [[ `echo 1 | grep 'prd'` ]]
#           tmux select-pane -P 'bg=colour52,fg=white'
#       elif [[ `echo 1 | grep 'stg'` ]]
#           tmux select-pane -P 'bg=colour25,fg=white'
#       end

#       # 通常通りssh続行
#       command ssh $argv[1]

#       # デフォルトの背景色に戻す
#       tmux select-pane -t $pane_id -P 'default'
#   else
#       command ssh $argv[1]
#   end
# end

# Dockerコンテナのシェルアクセスをfzfで簡単にする
function docker-exec
  set name (docker ps --format "{{.Names}}" | fzf)
  docker exec -it $name $argv
end

function fish_user_key_bindings
  bind \cr peco_select_history # Bind for prco history to Ctrl+r
  bind \cs 'peco_cd'
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

  if test (uname) = 'Darwin'
    cd
    sudo mv ~/nvim-osx64 ~/nvim_backup/nvim-osx64-(date '+%Y-%m-%d_%H:%M:%S')
    curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
    tar xzf ~/nvim-macos.tar.gz
    sudo rm -f ~/nvim-macos.tar.gz
  else if test (uname) = 'Linux'
    cd
    sudo mv /usr/local/bin/nvim ~/nvim_backup/nvim-linux-(date '+%Y-%m-%d_%H:%M:%S')
    curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
    chmod u+x ~/nvim.appimage
    sudo mv ~/nvim.appimage ~/nvim
    sudo mv ~/nvim /usr/local/bin
  end
end

function update_nvim_v5
  if test (uname) = 'Darwin'
    cd
    sudo rm -rf ~/nvim-osx64
    curl -LO https://github.com/neovim/neovim/releases/download/v0.5.0/nvim-macos.tar.gz
    tar xzf ~/nvim-macos.tar.gz
    sudo rm -f ~/nvim-macos.tar.gz
  else if test (uname) = 'Linux'
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

# 初回シェル時のみ tmux実行
# if test $SHLVL = 1
#   tmux new-session
# end

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

# neovimのpython2と3の環境でpip-packagesのupdate
function update_pyneovim
  pyenv activate neovim2
  pip install --upgrade pip
  pip install --upgrade pynvim
  pyenv deactivate neovim2
  pyenv activate neovim3
  pip install --upgrade pip
  pip install --upgrade pynvim
  pyenv deactivate neovim3
end

# ===Alias===
# Ubuntu
# package情報キャッシュの削除
alias ubuntu_cache_delete='sudo rm -rf /var/lib/apt/lists/*'
# GPG-agentの再起動
alias regpg='gpg-connect-agent reloadagent /bye'
alias gpgc='v ~/.gnupg/gpg-agent.conf'

# Git
alias git='hub'
alias g='git'
alias aad='git add .'
alias ad='git add'
alias aad='git add .'
alias unst='git restore --staged *'
alias pu='git push'
alias pulr='git pull --rebase'
alias pulrd='git pull --rebase upstream develop'
alias pulrm='git pull --rebase upstream master'
alias pulrma='git pull --rebase upstream main'
alias puf='git push -f'
alias pui='git push --set-upstream origin'
alias puod='git push origin develop'
alias puom='git push origin master'
alias puoma='git push origin main'
alias pul='git pull'
alias puld='git pull upstream develop'
alias pulm='git pull upstream master'
alias pulma='git pull upstream main'
alias st='git status'
alias gl='git log'
alias te='git tree'
alias gm='git merge'
alias dif='git diff'
alias difst='git diff --staged'
alias gr='git reset --mixed HEAD^'
alias amend='git commit --amend'
alias br='git branch'
alias brd='git branch -D'
alias brm='git branch -m'
alias bro='git branch --sort=-authordate | peco | xargs git checkout '
alias fe='git fetch'
alias cout='git checkout'
alias coutb='git switch -C'
alias cout-='git switch -'
alias coutr='git checkout .'
alias clone='git clone'
alias scloned='git clone --branch develop --depth 1'
alias sclonem='git clone --branch master --depth 1'
alias sclonema='git clone --branch main --depth 1'
alias coutd='git switch develop'
alias coutm='git switch master'
alias coutma='git switch main'
alias fepul='git fetch upstream pull/$argv[1]/head:$argv[2]'
alias ce="/usr/local/bin/gitmoji -c"
alias gopen='git open'
alias lz='lazygit'
alias sync='hub sync'
alias ggrep='git grep $argv[1] -- ':!mysql/' . '

# tmux
alias t='tmux'
alias tn='tmux new -s'
alias tls='tmux ls' # セッションの一覧表示
alias tlsc='tmux lsc' # 接続クライアントの一覧表示
alias ta='tmux a'
alias tat='tmux attach -t' # セッションを再開
alias td='tmux detach'
alias tk='tmux kill-session'
alias tkt='tmux kill-session -t'
alias tks='tmux kill-server' # tmux全体を終了
alias ret='tmux source ~/.tmux.conf'

# Docker
alias d='docker'
alias dip='docker inspect'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dnl='docker network ls'
alias dis='docker images'
alias dcm='docker commit'
alias dc='docker compose'
alias dce='docker compose exec'
alias dcup='docker compose up'
alias dcdown='docker compose down'
alias dcbuild='docker compose build'
alias dcrun='docker compose run'
alias dprune='docker system prune' # 停止コンテナ、タグ無しイメージ、未使用ボリューム、未使用ネットワーク一括削除
alias diprune='docker image prune' # 未使用イメージ一括削除
alias dvprune='docker volume prune' # 未使用ボリューム一括削除
alias dnprune='docker network prune' # 未使用ネットワーク一括削除
alias dbprune='docker builder prune' # build cacheの削除
alias ddf='docker system df' # Dockerが使っているストレージ容量を確認
alias dcu='docui'

# Rails
alias b='bundle'
alias be='bundle exec'
alias rd='bin/rails d'
alias rs='bin/rails s -b 0.0.0.0'
alias rc='bin/rails c'
alias rr='bin/rails routes'
alias rseed='bin/rails db:seed'
alias rdrop='bin/rails db:drop'
alias rroll='bin/rails db:rollback'
alias rcr='bin/rails db:create'
alias rmi='bin/rails db:migrate'
alias tmi='bundle exec rake tasks:migrate'
alias resque='env "QUEUE=*" VVERBOSE=true bundle exec rake environment resque:work'

# Npm
alias nr='npm run'
alias nw='npm run watch'
alias nb='npm run build'
alias nsb='npm run storybook'
alias nc='npm run clean'
alias ninfo='npm info'
alias ni='npm install'
alias nig='npm install -g'
alias nui='npm uninstall'
alias nci='npm ci'
alias npmlistg='npm list --depth=0 -g'
alias reflow='npx flow stop && npx flow start'

# yarn
alias ya='yarn add'
alias yr='yarn run'
alias yw='yarn run watch'
alias yb='yarn run build'
alias ysb='yarn run storybook'
alias yc='yarn run clean'

# Util
alias re='exec $SHELL -l'
alias ressh='sudo launchctl stop com.openssh.sshd'
alias bashc='nvim $DOTFILES_PATH/shell/bash/.bashrc'
alias zshc='nvim $DOTFILES_PATH/shell/zsh/.zshrc'
alias fishc='nvim $DOTFILES_PATH/shell/fish/config.fish'
alias tmuxc='nvim $DOTFILES_PATH/tmux/.tmux.conf'
alias vimc='nvim $DOTFILES_PATH/nvim/init.lua'
alias maps='nvim $DOTFILES_PATH/nvim/lua/keymap.lua'
alias cdd='cd $DOTFILES_PATH'
alias diary='cd ~/diary'
alias vim='nvim'
alias v='nvim'
# カレントディレクトリを指定した場合はDefxを起動させるために下記のファイルを同時に読み込む
alias vi='nvim . -S $DOTFILES_PATH/nvim/lua/plugins/defx.start.lua'
alias ls='ls -a1'
alias ll='ls -a1l'
alias note='cd ~/note'
alias ynote='cd ~/../yucchini/note'
alias vs='code .'
alias lslink='ls -la | grep "\->"'
alias lg='ls | rg'
alias c='clear'
alias sshc='nvim ~/.ssh/config'
alias ..="cd .."
alias ...='cd ../../'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias rmr='rm -r'
alias rf='rm -rf'
alias python3='python3.8'
alias shell='echo $SHELL'
alias p='pwd'
alias i='install'
alias ukios='cd ~/program/projects/uki_os'
alias drunuo='docker run -it --rm --privileged -e DISPLAY=(hostname):0 -v ~/.Xauthority:/root/.Xauthority -v $HOME/program/projects/uki_os/os:/root/os/ uki-os'
alias xlaunch='xhost + 127.0.0.1'
alias kl='kill -9'
alias chils='cd ~/program/projects/chillers/server'
alias chilf='cd ~/program/projects/chillers/frontend'
alias update_apt='sudo apt update && sudo apt upgrade'

if [ -d $DOTFILES_PATH/freee ]
  source $DOTFILES_PATH/freee/freee.config.fish
end
