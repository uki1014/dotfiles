function diary-rec --description 'ボイスメモを録音（VUメーター付き）して iCloud Drive/VoiceDiary に保存'
    set -l dir "$HOME/Library/Mobile Documents/com~apple~CloudDocs/VoiceDiary"
    mkdir -p "$dir"
    set -l file "$dir/"(date +%Y-%m-%d-%H%M%S)".wav"

    # 録音音量ブースト（dB）。引数で調整可（例: diary-rec 9）。デフォルト +6dB
    # クリップ（Clip 値が増える）したら下げる
    set -l g 6
    if test (count $argv) -ge 1
        set g $argv[1]
    end

    echo "🎙  録音中（システムデフォルト入力 / +$g dB）... 停止は Ctrl+C"
    echo "   ※ マイクを変えたい場合は「システム設定 → サウンド → 入力」でデフォルトを変更"

    # -S: VU メーター表示 / -c 1: mono / -r 16000: 16kHz（Whisper 最適）/ gain: 音量ブースト
    # ※ sox の coreaudio はデバイス名指定不可。システムデフォルト入力を使う
    rec -S -c 1 -r 16000 "$file" gain $g

    if test -f "$file"
        set -l size (du -h "$file" | cut -f1)
        echo ""
        echo "✅ 保存: $file ($size)"
        echo "   → Claude に「VoiceDiary のメモから日記にして」と伝えてください"
    else
        echo "❌ 録音に失敗（マイク権限: システム設定 → プライバシーとセキュリティ → マイク を確認）"
    end
end
