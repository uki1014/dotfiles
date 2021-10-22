#!/bin/bash -ue

change_keyrepeat() {
  defaults read -g InitialKeyRepeat
  defaults read -g KeyRepeat

  defaults write -g InitialKeyRepeat -int 13
  defaults write -g KeyRepeat -int 2
}

# If you want to run, pass something as an argument
if [ $# != 0 ]; then
  change_keyrepeat
fi
