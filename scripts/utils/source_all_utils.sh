#!/bin/bash -ue

utils=(
  check_brew
  has
  os
  setup_symlink
)

for util in ${utils[@]}; do
  source ~/dotfiles/scripts/utils/$util.sh
done
