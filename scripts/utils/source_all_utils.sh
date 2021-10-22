#!/bin/bash -ue

utils=(
  check_brew
  check_dotfiles
  has
  os
  setup_symlink
)

for util in ${utils[@]}; do
  source ~/dotfiles/scripts/utils/$util.sh
done
