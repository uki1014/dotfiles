vim.g.mapleader = ","

Maps.nmap('<S-C-p>ud', '"0p', Maps.n)
Maps.nmap('<Leader>d', '"_d', Maps.n)
Maps.nmap('x', '"_x', Maps.n)

-- 補完表示時のEnterで改行をしない
Maps.imap('<CR>', 'pumvisible() ? "<C-y>" : "<CR>"', Maps.ne)
Maps.imap('<C-n>', 'pumvisible() ? "<Down>" : "<C-n>"', Maps.ne)
Maps.imap('<C-p>', 'pumvisible() ? "<Up>" : "<C-p>"', Maps.ne)

-- よく使うText挿入
-- debugger
Maps.nmap('<Leader>de', ':call append(line("."), "debugger;")<CR>', Maps.n)
-- console.log
Maps.nmap('<Leader>log', ':call append(line("."), "console.log();")<CR>', Maps.n)
-- binding.pry
Maps.nmap('<Leader>bi', ':call append(line("."), "binding.pry")<CR>', Maps.n)

-- yank
Maps.nmap('Y', 'y$', Maps.n)

-- move lines
Maps.nmap('gj', 'ddp', Maps.n)
Maps.nmap('gk', 'dd2kp', Maps.n)

-- current cursorより前を削除
Maps.nmap('fd', 'v^d', Maps.n)

-- bufferの再読み込み
Maps.nmap('<Leader>e', ':edit<CR>', Maps.n)
Maps.nmap('<Leader>te', ':tabdo edit<CR>', Maps.n)

-- set number
Maps.nmap('<Leader>s', ':set number<CR>', Maps.ns)
-- set nonumber
Maps.nmap('<Leader>ns', ':set nonumber<CR>', Maps.ns)

-- redo
Maps.nmap('<S-u>', '<C-r>', Maps.n)

-- 現在開いているファイルのパスをcopyする
Maps.nmap('<Leader>b', ':lua CopyCurrentPath()<CR>', Maps.ns)

-- nvimのprofile取る
Maps.nmap('<Leader>ag', ':lua GetProfile()<CR>', Maps.ns)

-- 外部コマンド
Maps.nmap('<Leader>ca', ':!', Maps.n)

-- [[
-- 置換
--  /g: 対象全て
--  /c: 1つずつ確認しながら
-- ]]
Maps.nmap('<Leader>c', ':%s//', Maps.n)

-- 文字列一括削除
Maps.nmap('<Leader>d', ':g//d', Maps.n)

-- 保存・終了
Maps.nmap(';s', ':w<CR>', Maps.n)
Maps.nmap(';d', ':q!<CR>', Maps.n)
Maps.nmap(';a', ':qa<CR>', Maps.n)

-- messages
Maps.nmap(';h', ':messages<CR>', Maps.n)

-- 改行してnormal mode
Maps.nmap('<Space><CR>', 'o<ESC>', Maps.ns)

-- open init.lua
Maps.nmap('<Leader>.', ':new ~/.config/nvim/init.lua<CR>', Maps.n)
Maps.nmap('<Leader>vi', ':source~/.config/nvim/init.lua<CR>', Maps.n)

-- UpdateRemotePlugins
Maps.nmap('<Leader>ur', ':UpdateRemotePlugins<CR>', Maps.n)

-- backspaceキーで削除
Maps.nmap('dw', 'vb"_d', Maps.ns)

-- Select All
Maps.nmap('aa', 'gg<S-v>G', Maps.s)

-- Open BufExplorer
Maps.nmap('\\', '\be', Maps.none)

-- ハイライトを解除する
Maps.nmap('-', ':noh<CR>', Maps.ns)

-- syntax highlight再読み込み
Maps.nmap('<F12>', ':syntax sync fromstart<CR>', Maps.n)

-- fold
Maps.map('fz', 'zf', Maps.s) -- fold
Maps.nmap('zf', 'za', Maps.s) -- toggle fold
Maps.nmap('zs', ':mkview<CR>', Maps.s)
Maps.nmap('zl', ':loadview<CR>', Maps.s)

-- Windows
Maps.nmap('ss', ':split<Return><C-w>w', Maps.none)
Maps.nmap('sv', ':vsplit<Return><C-w>w', Maps.none)
-- Move Window
Maps.map('sh', '<C-w>h', Maps.s)
Maps.map('sk', '<C-w>k', Maps.s)
Maps.map('sj', '<C-w>j', Maps.s)
Maps.map('sl', '<C-w>l', Maps.s)
-- Resize Window
Maps.nmap('<Leader>h', '<C-w><', Maps.s)
Maps.nmap('<Leader>k', '<C-w>>', Maps.s)
Maps.nmap('<Leader>j', '<C-w>+', Maps.s)
Maps.nmap('<Leader>l', '<C-w>-', Maps.s)

