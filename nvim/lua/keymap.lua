local maps = require 'maps'

vim.g.mapleader = ","

maps.nmap('<S-C-p>ud', '"0p', maps.n)
maps.nmap('<Leader>d', '"_d', maps.n)
maps.nmap('x', '"_x', maps.n)

-- 補完表示時のEnterで改行をしない
maps.imap('<CR>', 'pumvisible() ? "<C-y>" : "<CR>"', maps.ne)
maps.imap('<C-n>', 'pumvisible() ? "<Down>" : "<C-n>"', maps.ne)
maps.imap('<C-p>', 'pumvisible() ? "<Up>" : "<C-p>"', maps.ne)

-- よく使うText挿入
-- debugger
maps.nmap('<Leader>de', ':call append(line("."), "debugger;")<CR>', maps.n)
-- console.log
maps.nmap('<Leader>log', ':call append(line("."), "console.log();")<CR>', maps.n)
-- binding.pry
maps.nmap('<Leader>bi', ':call append(line("."), "binding.pry")<CR>', maps.n)

-- yank
maps.nmap('Y', 'y$', maps.n)

-- move lines
maps.nmap('gj', 'ddp', maps.n)
maps.nmap('gk', 'dd2kp', maps.n)

-- current cursorより前を削除
maps.nmap('fd', 'v^d', maps.n)

-- bufferの再読み込み
maps.nmap('<Leader>e', ':edit<CR>', maps.n)
maps.nmap('<Leader>te', ':tabdo edit<CR>', maps.n)

-- set number
maps.nmap('<Leader>s', ':set number<CR>', maps.ns)
-- set nonumber
maps.nmap('<Leader>ns', ':set nonumber<CR>', maps.ns)

-- redo
maps.nmap('<S-u>', '<C-r>', maps.n)

-- 現在開いているファイルのパスをcopyする
maps.nmap('<Leader>b', ':lua CopyCurrentPath()<CR>', maps.ns)

-- nvimのprofile取る
maps.nmap('<Leader>ag', ':lua GetProfile()<CR>', maps.ns)

-- 外部コマンド
maps.nmap('<Leader>ca', ':!', maps.n)

-- [[
-- 置換
--  /g: 対象全て
--  /c: 1つずつ確認しながら
-- ]]
maps.nmap('<Leader>c', ':%s//', maps.n)

-- 文字列一括削除
maps.nmap('<Leader>d', ':g//d', maps.n)

-- 保存・終了
maps.nmap(';s', ':w<CR>', maps.n)
maps.nmap(';d', ':q!<CR>', maps.n)
maps.nmap(';a', ':qa<CR>', maps.n)

-- messages
maps.nmap(';h', ':messages<CR>', maps.n)

-- 改行してnormal mode
maps.nmap('<Space><CR>', 'o<ESC>', maps.ns)

-- open init.lua
maps.nmap('<Leader>.', ':new ~/.config/nvim/init.lua<CR>', maps.n)
maps.nmap('<Leader>vi', ':source~/.config/nvim/init.lua<CR>', maps.n)

-- UpdateRemotePlugins
maps.nmap('<Leader>ur', ':UpdateRemotePlugins<CR>', maps.n)

-- backspaceキーで削除
maps.nmap('dw', 'vb"_d', maps.ns)

-- Select All
maps.nmap('aa', 'gg<S-v>G', maps.s)

-- Open BufExplorer
maps.nmap('\\', '\be', maps.none)

-- ハイライトを解除する
maps.nmap('-', ':noh<CR>', maps.ns)

-- syntax highlight再読み込み
maps.nmap('<F12>', ':syntax sync fromstart<CR>', maps.n)

-- Tabs
maps.nmap('te', ':tabedit<Return>sf', maps.s)
maps.nmap('fl', ':tabnext<Return>', maps.s)
maps.nmap('fj', ':tabprev<Return>', maps.s)
maps.nmap('cl', ':tabclose<Return>', maps.s)

-- fold
maps.map('fz', 'zf', maps.s) -- fold
maps.nmap('zf', 'za', maps.s) -- toggle fold
maps.nmap('zs', ':mkview<CR>', maps.s)
maps.nmap('zl', ':loadview<CR>', maps.s)

-- Windows
maps.nmap('ss', ':split<Return><C-w>w', maps.none)
maps.nmap('sv', ':vsplit<Return><C-w>w', maps.none)
-- Move Window
maps.map('sh', '<C-w>h', maps.s)
maps.map('sk', '<C-w>k', maps.s)
maps.map('sj', '<C-w>j', maps.s)
maps.map('sl', '<C-w>l', maps.s)
-- Resize Window
maps.nmap('<Leader>h', '<C-w><', maps.s)
maps.nmap('<Leader>k', '<C-w>>', maps.s)
maps.nmap('<Leader>j', '<C-w>+', maps.s)
maps.nmap('<Leader>l', '<C-w>-', maps.s)

