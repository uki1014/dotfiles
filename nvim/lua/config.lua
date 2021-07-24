vim.g.loaded_netrwPlugin = '1'
vim.g.loaded_matchparen = '1'

vim.opt.backup = false
vim.opt.hidden = true
-- vimrcでマルチバイト文字を使用しているため設定
vim.opt.shortmess:append('c')
vim.opt.helplang = 'en'
vim.opt.autowrite = true
vim.opt.updatetime = 250
vim.opt.number = false
vim.opt.signcolumn = 'yes'
vim.opt.showmode = false
vim.opt.fileencodings = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.showtabline = 2
vim.opt.belloff = 'all'
vim.opt.title = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.cmd('set noswapfile')
vim.opt.shell = 'fish'
vim.opt.undolevels = 100
vim.opt.completeopt = 'menuone,noinsert'

-- work well in tmux
vim.cmd('set t_8f=^[[38;2;%lu;%lu;%lum]]')
vim.cmd('set t_8b=^[[48;2;%lu;%lu;%lum]]')
vim.cmd('set t_BE=')


-------------------------------------------------------------------------------
-- 検索
-------------------------------------------------------------------------------
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'split'

-- 文字色・描画
-- vim.opt.t_8f = '\b<Esc>[38;2;%lu;%lu;%lum'
-- vim.opt.t_8b = '\b<Esc>[48;2;%lu;%lu;%lum'
-- vim.opt.t_BE = ''
vim.opt.lazyredraw = true
vim.opt.showmatch = true
vim.opt.mat = 2

-------------------------------------------------------------------------------
-- indent
-------------------------------------------------------------------------------
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.formatoptions:remove('ro') -- 改行時のコメントアウトをoff
vim.cmd('au FileType * setlocal formatoptions-=ro')
-- vim.opt.nowrap = false
vim.cmd('set nowrap')
vim.opt.wildmenu = true
vim.opt.wildmode = 'list:full'
vim.opt.mouse = 'a'

vim.cmd('filetype plugin indent on')

vim.cmd('augroup fileTypeIndent')
vim.cmd('au!')
vim.cmd('au FileType go setlocal tabstop=4 shiftwidth=4')
vim.cmd('au FileType python setlocal tabstop=4 shiftwidth=4')
vim.cmd('augroup END')

-------------------------------------------------------------------------------
-- Cursor line
-------------------------------------------------------------------------------
vim.opt.cursorline = true
vim.opt.guicursor = 'a:block'
vim.opt.scrolloff = 100 --カーソルが常に中央に来るようにする
vim.cmd('highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40')
vim.cmd('highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000')

function RestoreCursorPosition()
  if vim.fn.line("'\b'") > 0 and vim.fn.line("'\b'") <= vim.fn.line('$') then
    vim.fn.exe('normal! g')
  end
end

-- Memolize cursorline
vim.cmd('augroup cursorlineRestore')
vim.cmd('au!')
vim.cmd('au BufReadPost * lua RestoreCursorPosition()')
vim.cmd('augroup END')


-------------------------------------------------------------------------------
-- Extensions
-------------------------------------------------------------------------------
vim.opt.suffixesadd = '.js,.es,.jsx,.ts,.tsx,.json,.css,.less,.sass,.style,.php,.py,.md,.java,.rb,.vim,.lua,.vimrc,.conf,.go'
vim.opt.path:append('**')
vim.opt.wildignore:append('*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store/*,*/node_modules/*')
-- Enable json comment(only tsconfig)
vim.cmd('au BufRead,BufNewFile tsconfig.json setf filetype=jsonc')
-- vim.cmd('au FileType json syntax match Comment +\b/\b/.\b+$+')
-- JavaScript
vim.cmd('au BufNewFile,BufRead *.es6 setf javascript')
-- TypeScript
vim.cmd('au BufNewFile,BufRead *.ts setf typescript')
vim.cmd('au BufNewFile,BufRead *.tsx setf filetype=typescript.tsx')
-- Markdown
vim.cmd('au BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} setf filetype=markdown')
-- Flow
vim.cmd('au BufNewFile,BufRead *.flow setf filetype=javascript')
-- fish
vim.cmd('au BufNewFile,BufRead fish_funced setf filetype=fish')

-- vim.cmd('augroup ReactFiletypes')
-- vim.cmd('au!')
-- vim.cmd('au BufRead,BufNewFile *.jsx setf filetype=javascriptreact')
-- vim.cmd('au BufRead,BufNewFile *.tsx setf filetype=typescriptreact')
-- vim.cmd('augroup END')
--[[
]]


if vim.fn.has('conceal') == 0 then
  vim.opt.conceallevel = 2
  vim.opt.concealcursor = 'niv'
end

-- clipboard
vim.opt.clipboard:append('unnamedplus')

-------------------------------------------------------------------------------
-- Utils
-------------------------------------------------------------------------------

-- vimの外部で変更を受けたバッファがないかを調べる
-- 別windowに入ったときや、入力フォーカスを得たときに発動
vim.cmd('augroup vimrc-misc')
vim.cmd('au!')
vim.cmd('au WinEnter,FocusGained * checktime')
vim.cmd('augroup END')

vim.cmd('au WinEnter,BufRead,BufNew,Syntax * call matchadd("Todo", "\bW\bzs\b(TODO\b|\b|FIXME\b|CHANGED\b|XXX\b|BUG\b|HACK\b|NOTE\b|MEMO\b|INFO\b|IDEA\b)")')

vim.g.python_host_prog = os.getenv('PYENV_ROOT')..'/versions/neovim2/bin/python'
vim.g.python3_host_prog = os.getenv('PYENV_ROOT')..'/versions/neovim3/bin/python'
vim.g.ruby_host_prog = os.getenv('RBENV_ROOT')..'/versions/2.6.6/bin/neovim-ruby-host'
vim.g.node_host_prog = os.getenv('NODENV_ROOT')..'/versions/12.20.1/bin/neovim-node-host'

--[[
" ペーストするときに自動インデントでずれないようにする
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif
]]

-- undo保存先
if vim.fn.has('persistent_undo') == 1 then
  undo_path = vim.fn.expand('~/.config/nvim/sessions')
  if vim.fn.isdirectory(undo_path) == 0 then
    vim.fn.mkdir(undo_path, 'p')
  end
  vim.opt.undodir = undo_path
  vim.opt.undofile = true
end

-------------------------------------------------------------------------------
-- Color scheme
-------------------------------------------------------------------------------
if vim.fn.exists('&termguicolors') and vim.fn.exists('&winblend') then
  vim.g.syntax = true
  vim.opt.background = 'dark'
  vim.g.colors_name = 'NeoSolarized'
  vim.g.neosolarized_termtrans = 1
  vim.opt.termguicolors = true
  vim.opt.winblend = 0
  vim.opt.wildoptions = 'pum'
  vim.opt.pumblend = 5
  vim.g.solarized_termcolors = 256
  vim.cmd('runtime ../colors/NeoSolarized.vim')
end
