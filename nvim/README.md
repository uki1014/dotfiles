## vim keymaps

### utils

| keybind | operation                              |
| ------- | -------------------------------------- |
| zH      | 画面を半ページ分左にずらす             |
| zL      | 画面を半ページ分右にずらす             |
| s       | カーソルの文字を消して挿入             |
| S       | カーソルの行を消して挿入               |
| qa      | 全てのウィンドウを閉じて終了           |
| qa!     | 全てのウィンドウを保存せず閉じて終了   |
| D       | 現在位置から行末まで削除               |
| =       | 自動インデント修正でずれたのを一括修正 |

### vim mode

| cmd                    | mode                                       |
| ---------------------- | ------------------------------------------ |
| map, noremap, unmap    | ノーマル, ビジュアル, 選択, オペレータ待機 |
| nmap, nnoremap, nunmap | ノーマル                                   |
| vmap, vnoremap, vunmap | ビジュアル, 選択                           |
| smap, snoremap, sunmap | 選択                                       |
| xmap, xnoremap, xunmap | ビジュアル                                 |
| omap, onremap, ounmap  | オペレータ待機                             |
| map!, noremap!, unmap! | 挿入, コマンドライン                       |
| imap, inoremap, iunmap | 挿入                                       |
| lmap, lnoremap, lunmap | 挿入, コマンドライン, Lang-Arg             |
| cmap, cnoremap, cunmap | コマンドライン                             |
