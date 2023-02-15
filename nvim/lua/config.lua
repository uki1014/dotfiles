vim.g.loaded_netrwPlugin = "1"
vim.g.loaded_matchparen = "1"

-- https://qiita.com/delphinus/items/3c47567e1af13add968e
-- vim.fn.setcellwidths {
--   { 0x2500, 0x257f, 2  },
--   { 0x2100, 0x214d, 2  },
--     ...
-- }

vim.opt.backup = false
vim.opt.hidden = true
-- vimrcでマルチバイト文字を使用しているため設定
vim.opt.shortmess:append("c")
vim.opt.helplang = "en"
vim.opt.autowrite = true
vim.opt.updatetime = 250
vim.opt.number = false
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.fileencodings = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.showtabline = 2
vim.opt.belloff = "all"
vim.opt.title = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.cmd("set noswapfile")
vim.opt.shell = "fish"
vim.opt.undolevels = 100
vim.opt.completeopt = "menuone,noinsert"
vim.opt.laststatus = 1

-- work well in tmux
vim.cmd("set t_8f=^[[38;2;%lu;%lu;%lum]]")
vim.cmd("set t_8b=^[[48;2;%lu;%lu;%lum]]")
vim.cmd("set t_BE=")

-------------------------------------------------------------------------------
-- 検索
-------------------------------------------------------------------------------
-- 検索時に大文字・小文字の区別を付けない
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

-- 文字色・描画
vim.opt.lazyredraw = true
vim.opt.showmatch = true
vim.opt.mat = 2

-------------------------------------------------------------------------------
-- indent
-------------------------------------------------------------------------------
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.formatoptions:remove("ro") -- 改行時のコメントアウトをoff
vim.cmd("au FileType * setlocal formatoptions-=ro")
-- vim.opt.nowrap = false
vim.cmd("set nowrap")
vim.opt.wildmenu = true
vim.opt.wildmode = "list:full"
vim.opt.mouse = "a"

vim.cmd("filetype plugin indent on")

-- golangでindentLineを上手く効かせるため
vim.cmd("au FileType go setlocal expandtab")

vim.cmd("augroup fileTypeIndent")
vim.cmd("au!")
vim.cmd("au FileType go setlocal tabstop=4 shiftwidth=4")
vim.cmd("au FileType python setlocal tabstop=4 shiftwidth=4")
vim.cmd("augroup END")

-------------------------------------------------------------------------------
-- Cursor line
-------------------------------------------------------------------------------
vim.opt.cursorline = true
vim.opt.guicursor = "a:block"
vim.opt.scrolloff = 100 --カーソルが常に中央に来るようにする
vim.cmd("highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40")
vim.cmd("highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000")

function RestoreCursorPosition()
	if vim.fn.line("'\b'") > 0 and vim.fn.line("'\b'") <= vim.fn.line("$") then
		vim.fn.exe("normal! g")
	end
end

-- Memolize cursorline
vim.cmd("augroup cursorlineRestore")
vim.cmd("au!")
vim.cmd("au BufReadPost * lua RestoreCursorPosition()")
vim.cmd("augroup END")

-------------------------------------------------------------------------------
-- Highlight
-------------------------------------------------------------------------------
vim.cmd("augroup highlight_yank")
vim.cmd("au!")
vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}')
vim.cmd("augroup END")

-------------------------------------------------------------------------------
-- Extensions
-------------------------------------------------------------------------------

-- suffixaddを追加するとgfでファイル検索するときの対象になる
vim.opt.suffixesadd =
	".sh,.bash,.zsh,.fish,.js,.es,.jsx,.ts,.tsx,.json,.css,.less,.sass,.style,.php,.py,.rs,.md,.java,.rb,.vim,.lua,.vimrc,.conf,.go,.coffee,.eco,.jst.eco,.erb"
vim.opt.path:append("**")
vim.opt.wildignore:append("*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store/*,*/node_modules/*")
-- Enable json comment(only tsconfig)
vim.cmd("au BufNewFile,BufRead *.json setf jsonc")
vim.cmd("au BufNewFile,BufRead *.swcrc setf jsonc")
-- JavaScript
vim.cmd("au BufNewFile,BufRead *.es6 setf javascript")
-- TypeScript
vim.cmd("au BufNewFile,BufRead *.ts setf typescript")
vim.cmd("au BufNewFile,BufRead *.tsx setf typescript.tsx")
-- CoffeeScript
vim.cmd("au BufNewFile,BufRead *.coffee setf coffee")
-- Eco (masonは全く別のテンプレートエンジンだが、適してるので使う)
vim.cmd("au BufNewFile,BufRead *.eco setf mason")
-- Markdown
vim.cmd("au BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} setf markdown")
-- Flow
vim.cmd("au BufNewFile,BufRead *.flow setf javascript")
-- fish
vim.cmd("au BufNewFile,BufRead *.fish setf fish")
-- Ruby
vim.cmd("au BufNewFile,BufRead Dangerfile* setf ruby")
vim.cmd("au BufNewFile,BufRead .pryrc,.aprc setf ruby")
vim.cmd("au BufNewFile,BufRead *.rbi,.aprc setf ruby")
-- csv
vim.cmd("au BufNewFile,BufRead *.csv setf csv")
-- tsv
vim.cmd("au BufNewFile,BufRead *.tsv setf tsv")
-- html
vim.cmd("au BufNewFile,BufRead .jet setf html")
-- envrc
vim.cmd("au BufNewFile,BufRead .envrc setf sh")

if vim.fn.has("conceal") == 0 then
	vim.opt.conceallevel = 2
	vim.opt.concealcursor = "niv"
end

-- clipboard
vim.opt.clipboard:append("unnamedplus")

-------------------------------------------------------------------------------
-- Utils
-------------------------------------------------------------------------------

-- vimの外部で変更を受けたバッファがないかを調べる
-- 別windowに入ったときや、入力フォーカスを得たときに発動
vim.cmd("augroup vimrc-misc")
vim.cmd("au!")
vim.cmd("au WinEnter,FocusGained * checktime")
vim.cmd("augroup END")

vim.cmd(
	'au WinEnter,BufRead,BufNew,Syntax * call matchadd("Todo", "\bW\bzs\b(TODO\b|\b|FIXME\b|CHANGED\b|XXX\b|BUG\b|HACK\b|NOTE\b|MEMO\b|INFO\b|IDEA\b)")'
)

-- undo保存先
if vim.fn.has("persistent_undo") == 1 then
	local undo_path = vim.fn.expand("~/.config/nvim/undo")
	if vim.fn.isdirectory(undo_path) == 0 then
		vim.fn.mkdir(undo_path, "p")
	end
	vim.opt.undodir = undo_path
	vim.opt.undofile = true
end

function CopyCurrentPath()
	vim.cmd('let @+ = expand("%")')
	vim.cmd('echo expand("%")')
end

function GetProfile()
	vim.cmd("profile start ~/dotfiles/profile.log")
	vim.cmd("profile func *")
	vim.cmd("profile file *")
end

-------------------------------------------------------------------------------
-- Color scheme
-------------------------------------------------------------------------------
if vim.fn.exists("&termguicolors") and vim.fn.exists("&winblend") then
	vim.g.syntax = true
	vim.opt.background = "dark"
	vim.g.colors_name = "NeoSolarized"
	vim.g.neosolarized_termtrans = 1
	vim.opt.termguicolors = true
	vim.opt.winblend = 0
	vim.opt.wildoptions = "pum"
	vim.opt.pumblend = 5
	vim.g.solarized_termcolors = 256
	vim.cmd("colorscheme NeoSolarized")
	-- vim.cmd('runtime ../colors/NeoSolarized.vim')
end
