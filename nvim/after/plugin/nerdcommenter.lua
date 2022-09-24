-- デフォルトのキーマッピングをオフ
vim.g.NERDCreateDefaultMappings = '0'
-- コメントアウト時にスペースを1つ挿入
vim.g.NERDSpaceDelims = '1'
-- コメント記号を左に揃える
vim.g.NERDDefaultAlign = 'left'
-- fishのコメントアウトが対応していなかったので追加
vim.g.NERDCustomDelimiters = { fish = { left = '#' } }

Maps.nmap('<Leader>f', '<Plug>NERDCommenterToggle', Maps.none)
Maps.vmap('<Leader>f', '<Plug>NERDCommenterToggle', Maps.none)
-- コメントアウトしてインサートモード
Maps.nmap('<Leader>r', '<Plug>NERDCommenterAppend', Maps.none)
-- ブロックコメントアウト
Maps.nmap('<Leader>bf', '<Plug>NERDCommenterSexy', Maps.none)
Maps.vmap('<Leader>bf', '<Plug>NERDCommenterSexy', Maps.none)
