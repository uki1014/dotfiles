#!/bin/bash -ue

change_keyrepeat() {
  defaults read -g InitialKeyRepeat
  defaults read -g KeyRepeat

  defaults write -g InitialKeyRepeat -int 13
  defaults write -g KeyRepeat -int 2
}

# If you want to run, pass something as an argument
[ ! $# == 0 ] && change_keyrepeat
