#!/bin/bash -ue

# 今のMacで明示的に変えている設定だけを書く。macOSの初期値のままの項目は書かない
# キー名の調べ方: defaults read > before.txt → システム設定で変更 → defaults read > after.txt → diff

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

# キーボード
defaults write -g InitialKeyRepeat -int 13
defaults write -g KeyRepeat -int 2
defaults write -g com.apple.keyboard.fnState -bool false
defaults write com.apple.HIToolbox AppleFnUsageType -int 0

# 拡張子を常に表示
defaults write -g AppleShowAllExtensions -bool true

# 音量を変えたときにフィードバック音を鳴らさない
defaults write -g com.apple.sound.beep.feedback -int 0

# トラックパッド（内蔵とMagic Trackpadの両方に書く）
for domain in com.apple.AppleMultitouchTrackpad com.apple.driver.AppleBluetoothMultitouch.trackpad; do
	defaults write $domain Clicking -bool true
	defaults write $domain TrackpadRightClick -bool true
	defaults write $domain TrackpadThreeFingerDrag -bool true
	defaults write $domain TrackpadThreeFingerTapGesture -int 0
done
# クリックの強さ: 弱い
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 0
# ログイン画面など、ユーザー設定より前の場面でもタップでクリックできるようにする
defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1
defaults write -g com.apple.trackpad.scaling -float 2
defaults write -g com.apple.trackpad.forceClick -bool true

# マウス
defaults write -g com.apple.mouse.scaling -float 1

# Dock
defaults write com.apple.dock tilesize -float 49
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -float 106
defaults write com.apple.dock show-recents -bool false
# 右下のホットコーナーでクイックメモ
defaults write com.apple.dock wvous-br-corner -int 14

# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder FXPreferredViewStyle -string clmv
defaults write com.apple.finder NewWindowTarget -string PfLo
defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/Downloads/"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# スクリーンショット
defaults write com.apple.screencapture location -string "$HOME/Downloads"

# メニューバーの時計: 日付・曜日・秒まで24時間表示
defaults write com.apple.menuextra.clock ShowDate -int 1
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
defaults write com.apple.menuextra.clock Show24Hour -bool true
defaults write com.apple.menuextra.clock ShowSeconds -bool true

# メニューバーのバッテリー残量を%表示
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true

# 電源接続時の効果音を鳴らさない
defaults write com.apple.PowerChime ChimeOnNoHardware -bool true

# macOSの言語切替時の吹き出し表示を消す
sudo mkdir -p /Library/Preferences/FeatureFlags/Domain
sudo /usr/libexec/PlistBuddy -c "Add 'redesigned_text_cursor:Enabled' bool false" /Library/Preferences/FeatureFlags/Domain/UIKit.plist 2>/dev/null \
	|| sudo /usr/libexec/PlistBuddy -c "Set 'redesigned_text_cursor:Enabled' false" /Library/Preferences/FeatureFlags/Domain/UIKit.plist

for app in "Dock" \
	"Finder" \
	"SystemUIServer" \
	"ControlCenter" \
	"PowerChime"; do
	killall "${app}" &> /dev/null || true
done

echo $(tput setaf 2)キーボード・トラックパッドの一部はログアウト後に反映されます$(tput sgr0)
