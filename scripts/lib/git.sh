#!/bin/bash -ue

create_token_file() {
  ln -s ~/dotfiles/git/.git-templates ~/
  git secrets --register-aws --global
  touch ~/dotfiles/git/token.fish
  echo 'Please set GITHUB_TOKEN and GITHUB_USERNAME in "~/dotfiles/git/token.fish"'
}

if [ $# != 0 ]; then
  create_token_file
fi
