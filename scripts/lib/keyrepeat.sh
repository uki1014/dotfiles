#!/bin/bash

# 実行したコマンドを表示
# set -x
set -ue

defaults read -g InitialKeyRepeat
defaults read -g KeyRepeat

defaults write -g InitialKeyRepeat -int 13
defaults write -g KeyRepeat -int 2
