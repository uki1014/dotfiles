# ===Alias===
# Ubuntu
# package情報キャッシュの削除
alias ubuntu_cache_delete='sudo rm -rf /var/lib/apt/lists/*'
# GPG-agentの再起動
alias regpg='gpg-connect-agent reloadagent /bye'
alias gpgc='v ~/.gnupg/gpg-agent.conf'

# Git
# alias git='hub'
alias g='git'
alias aad='git add .'
alias ad='git add'
alias aad='git add .'
alias unst='git restore --staged *'
alias pu='git push'
alias puf='git push -f'
alias puno='git push --no-verify'
alias pufno='git push -f --no-verify'
alias pui='git push --set-upstream origin'
alias puino='git push --set-upstream origin --no-verify'
alias puod='git push origin develop'
alias puom='git push origin master'
alias puoma='git push origin main'
alias pul='git pull'
alias puld='git pull upstream develop'
alias pulm='git pull upstream master'
alias pulma='git pull upstream main'
alias pulr='git pull --rebase'
alias pulrd='git pull --rebase upstream develop'
alias pulrm='git pull --rebase upstream master'
alias pulrma='git pull --rebase upstream main'
alias pr='gh pr list --assignee $GITHUB_USERNAME | fzf | cut -f1 | xargs -I {} gh pr checkout {}'
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
alias bd='git branch --sort=-authordate | peco | xargs git branch -D '
alias brm='git branch -m'
alias bo='git branch --sort=-authordate | peco | xargs git checkout '
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
alias drmi='docker rmi'
alias dco='docker container'
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
alias rs='bin/rails s'
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
alias nid='npm install -D'
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
alias alic='nvim $DOTFILES_PATH/shell/alias.sh'
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
alias chil='cd ~/program/projects/Chillers'
alias chils='cd ~/program/projects/chillers/server'
alias chilf='cd ~/program/projects/chillers/frontend'
alias update_apt='sudo apt update && sudo apt upgrade && sudo apt autoremove'
alias ubuntu_cache_clear='sudo sysctl -w vm.drop_caches=3'
alias mysqlstatus='sudo service mysql status'
alias load_back_up_mysql='mysql -u mysql -proot --protocol tcp < tmp/development-backup.sql'
alias brewall='~/dotfiles/scripts/utils/check_brew.sh 0'
