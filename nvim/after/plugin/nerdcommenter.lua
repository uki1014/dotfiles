-- デフォルトのキーマッピングをオフ
vim.g.NERDCreateDefaultMappings = '0'
-- コメントアウト時にスペースを1つ挿入
vim.g.NERDSpaceDelims = '1'
-- コメント記号を左に揃える
vim.g.NERDDefaultAlign = 'left'
-- fishのコメントアウトが対応していなかったので追加
vim.g.NERDCustomDelimiters = { fish = { left = '#' } }

maps.nmap('<Leader>f', '<Plug>NERDCommenterToggle', maps.none)
maps.vmap('<Leader>f', '<Plug>NERDCommenterToggle', maps.none)
-- コメントアウトしてインサートモード
maps.nmap('<Leader>r', '<Plug>NERDCommenterAppend', maps.none)
-- ブロックコメントアウト
maps.nmap('<Leader>bf', '<Plug>NERDCommenterSexy', maps.none)
maps.vmap('<Leader>bf', '<Plug>NERDCommenterSexy', maps.none)
