export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
# ===Alias===
# Git
alias cm='git commit -m "$1"'
alias ad='git add'
alias pu='git push'
alias puf='git push -f'
alias pui='git push --set-upstream origin $1'
alias pul='git pull'
alias puld='git pull pr develop'
alias st='git status'
alias gl='git log'
alias diff='git diff'
alias gr='git reset'
alias ga='git commit --amend'
alias gb='git branch'
alias ct='git checkout'
alias ctb='git checkout -b'
alias ctm='git checkout -'
alias clone='git clone'
alias ctd='git checkout develop'

# Docker
alias dc='docker'
alias dce='docker-compose exec'
alias dcp='docker-compose'
alias dps='docker ps'
alias dcup='docker-compose up'
alias dcdown='docker-compose down'
alias dcbuild='docker-compose build'
alias dcrun='docker-compose run'
alias dprune='docker system prune' # 停止コンテナ、タグ無しイメージ、未使用ボリューム、未使用ネットワーク一括削除
alias diprune='docker image prune' # 未使用イメージ一括削除
alias dvprune='docker volume prune' # 未使用ボリューム一括削除
alias dnprune='docker network prune' # 未使用ネットワーク一括削除

# Rails
alias be='bundle exec'
alias rd='bin/rails d'
alias rg='bin/rails g'
alias rs='bin/rails s -b 0.0.0.0'
alias rc='bin/rails c'
alias rr='bin/rails routes'
alias rseed='bin/rails db:seed'
alias rdrop='bin/rails db:drop'
alias rroll='bin/rails db:rollback'
alias rcr='bin/rails db:create'
alias rmi='bin/rails db:migrate'

# Django
alias prun='python manage.py runserver 0.0.0.0:8000'
alias pmmi='python manage.py makemigrations'
alias pmi='python manage.py migrate'
alias pcsu='python manage.py createsuperuser'
alias psh='python manage.py shell'

# Npm
alias nr='npm run'
alias yr='yarn run'
alias nc='npm run clean'
alias yc='yarn clean'
alias nw='npm run watch'
alias yw='yarn run watch'
alias stb='npm run storybook'
alias ninfo='npm info'
alias ni='npm install'
alias nci='npm ci'
alias npmlistg='npm list --depth=0 -g'

# Util
alias sa='ssh-add -K'
alias rel='exec $SHELL -l'
alias ressh='sudo launchctl stop com.openssh.sshd'
alias bashc='cd && nvim ~/dotfiles/.bashrc'
alias zshrc='cd && nvim ~/dotfiles/.zshrc'
alias fishc='cd && nvim ~/dotfiles/fish/config.fish'
alias tmuxc='cd && nvim ~/dotfiles/.tmux.conf'
alias cdd='cd && cd dotfiles/'
alias vi='nvim'
alias ls='exa --icons -a'
alias lsl='exa -1 --icons -a'
alias cdnote='cd && cd note'
alias cdynote='cd && cd ../yucchini/note'
alias vs='code .'
alias lslink='ls -la | grep "\->"'
alias lg='ls | grep'
alias cl='clear'
alias sshc='cd && nvim .ssh/config'

if [ -d ~/dotfiles/freee ]; then
  echo 'source freee.bash!'
  source ~/dotfiles/freee/freee.bash
fi

# if [[ $IS_FISH_START == YES ]]; then
#   # 最後にfish起動
#   exec fish
# else
#   # fishを読み込まない時はtmuxの起動確認と秘密鍵の読み込み
#   if [[ ! -n $TMUX && $- == *l* ]]; then
#     # get the IDs
#     ID="`tmux list-sessions`"
#     if [[ -z "$ID" ]]; then
#       tmux new-session
#     fi
#     create_new_session="Create New Session"
#     ID="$ID\n${create_new_session}:"
#     ID="`echo $ID | $PERCOL | cut -d: -f1`"
#     if [[ "$ID" = "${create_new_session}" ]]; then
#       tmux new-session
#     elif [[ -n "$ID" ]]; then
#       tmux attach-session -t "$ID"
#     else
#       :  # Start terminal normally
#     fi
#   fi
#   sa
# fi
