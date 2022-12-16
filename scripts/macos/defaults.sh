#!/bin/bash -ue

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

defaults read -g InitialKeyRepeat
defaults read -g KeyRepeat

defaults write -g InitialKeyRepeat -int 13
defaults write -g KeyRepeat -int 2

# 隠しファイルを常に表示させる
defaults write com.apple.finder AppleShowAllFiles TRUE

defaults write com.apple.desktopservices DSDontWriteNetworkStores True
killall Finder

# Show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Display date, day, and time in the menu bar
defaults write com.apple.menuextra.clock DateFormat -string 'EEE d MMM HH:mm'

# Display battery level in the menu bar
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

for app in "Dock" \
	"Finder" \
	"SystemUIServer"; do
	killall "${app}" &> /dev/null
done


