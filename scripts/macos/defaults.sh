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

# Turn off the sound effects on power charge
defaults write com.apple.PowerChime ChimeOnNoHardware -bool true;killall PowerChime

# macOSの言語切替時の吹き出し表示を消す
sudo mkdir -p /Library/Preferences/FeatureFlags/Domain
sudo /usr/libexec/PlistBuddy -c "Add 'redesigned_text_cursor:Enabled' bool false" /Library/Preferences/FeatureFlags/Domain/UIKit.plist

for app in "Dock" \
	"Finder" \
	"SystemUIServer"; do
	killall "${app}" &> /dev/null
done


