vim.g.mapleader = ","

vim.api.nvim_set_keymap('n', '<S-C-p>ud', '"0p', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>d', '"_d', { noremap = true })
vim.api.nvim_set_keymap('n', 'x', '"_x', { noremap = true })

--[[
 Increment/decrement(memo用)
 nnoremap <C-a>
 nnoremap <C-x>
]]

-- 補完表示時のEnterで改行をしない
vim.api.nvim_set_keymap('i', '<CR>', 'pumvisible() ? "<C-y>" : "<CR>"', { noremap = true, expr = true })
vim.api.nvim_set_keymap('i', '<C-n>', 'pumvisible() ? "<Down>" : "<C-n>"', { noremap = true, expr = true })
vim.api.nvim_set_keymap('i', '<C-p>', 'pumvisible() ? "<Up>" : "<C-p>"', { noremap = true, expr = true })

-- よく使うText挿入
-- debugger
vim.api.nvim_set_keymap('n', '<Leader>de', ':call append(line("."), "debugger;")<CR>', { noremap = true })
-- console.log
vim.api.nvim_set_keymap('n', '<Leader>log', ':call append(line("."), "console.log();")<CR>', { noremap = true })
-- binding.pry
vim.api.nvim_set_keymap('n', '<Leader>bi', ':call append(line("."), "binding.pry")<CR>', { noremap = true })

-- bufferの再読み込み
vim.api.nvim_set_keymap('n', '<Leader>e', ':edit<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>te', ':tabdo edit<CR>', { noremap = true })

-- set number
vim.api.nvim_set_keymap('n', '<Leader>s', ':set number<CR>', { noremap = true, silent = true })
-- set nonumber
vim.api.nvim_set_keymap('n', '<Leader>ns', ':set nonumber<CR>', { noremap = true, silent = true })

-- redo
vim.api.nvim_set_keymap('n', '<S-u>', '<C-r>', { noremap = true })

-- 現在開いているファイルのパスをcopyする
vim.api.nvim_set_keymap('n', '<Leader>b', ':let @+ = expand("%")<CR>', { noremap = true, silent = true })

-- 外部コマンド
vim.api.nvim_set_keymap('n', '<Leader>ca', ':!', { noremap = true })

-- 置換(ファイル内で対象のものを全て置換したいときはサイトに/gつける)
vim.api.nvim_set_keymap('n', '<Leader>c', ':%s//', { noremap = true })

-- 保存・終了
vim.api.nvim_set_keymap('n', ';s', ':w<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ';d', ':q!<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', ';a', ':qa<CR>', { noremap = true })

-- messages
vim.api.nvim_set_keymap('n', ';h', ':messages<CR>', { noremap = true })

-- 改行してnormal mode
vim.api.nvim_set_keymap('n', '<Space><CR>', 'o<ESC>', { noremap = true, silent = true })

-- open init.lua
vim.api.nvim_set_keymap('n', '<Leader>.', ':new ~/.config/nvim/init.lua<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>vi', ':source~/.config/nvim/init.lua<CR>', { noremap = true })

-- UpdateRemotePlugins
vim.api.nvim_set_keymap('n', '<Leader>ur', ':UpdateRemotePlugins<CR>', { noremap = true })

-- backspaceキーで削除
vim.api.nvim_set_keymap('n', 'dw', 'vb"_d', { noremap = true, silent = true })

-- Select All
vim.api.nvim_set_keymap('n', 'aa', 'gg<S-v>G', { noremap = false, silent = true })

-- Open BufExplorer
vim.api.nvim_set_keymap('n', '\\', '\be', { noremap = false })

-- ハイライトを解除する
vim.api.nvim_set_keymap('n', '-', ':noh<CR>', { noremap = true, silent = true })

-- syntax highlight再読み込み
vim.api.nvim_set_keymap('n', '<F9>', ':syntax sync fromstart<CR>', { noremap = true })

-- Tabs
vim.api.nvim_set_keymap('n', 'te', ':tabedit<Return>sf', { silent = true })
vim.api.nvim_set_keymap('n', 'fl', ':tabnext<Return>', { silent = true })
vim.api.nvim_set_keymap('n', 'fj', ':tabprev<Return>', { silent = true })
vim.api.nvim_set_keymap('n', 'cl', ':tabclose<Return>', { silent = true })

-- Windows
vim.api.nvim_set_keymap('n', 'ss', ':split<Return><C-w>w', { noremap = false })
vim.api.nvim_set_keymap('n', 'sv', ':vsplit<Return><C-w>w', { noremap = false })
-- Move Window
vim.api.nvim_set_keymap('', 'sh', '<C-w>h', { silent = true })
vim.api.nvim_set_keymap('', 'sk', '<C-w>k', { silent = true })
vim.api.nvim_set_keymap('', 'sj', '<C-w>j', { silent = true })
vim.api.nvim_set_keymap('', 'sl', '<C-w>l', { silent = true })
-- Resize Window
vim.api.nvim_set_keymap('n', '<Leader>h', '<C-w><', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>k', '<C-w>>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>j', '<C-w>+', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>l', '<C-w>-', { silent = true })

