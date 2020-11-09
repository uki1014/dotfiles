" " general settings {{{

" " Leaderキーをスペースに設定 {{{
" let g:mapleader = "\<Space>"
" " }}}

" " マクロで効果発揮 {{{
" set lazyredraw
" set ttyfast
" " }}}

" " 矩形選択時に文字の無いところまで選択範囲を広げる {{{
" set virtualedit=block
" " }}}

" " ファイル保存時に整形する {{{
" let s:format_targets = {
"       \ 'javascript': '--use-tabs=false --single-quote=true %',
"       \ 'html': '--use-tabs=false --single-quote=true %',
"       \ 'css': '',
"       \ 'json': '--tab',
"       \ 'vue':  '--use-tabs=false --single-quote=true %',
"       \ 'vim': '',
"       \ 'java': '',
"       \ }

" " format function
" function! Format() abort
"   " if format target is not exsist, nothing to do
"   if !has_key(s:format_targets, &ft)
"     return
"   endif

"   let args = s:format_targets[&ft]
"   let pos = getcurpos()

"   " use js-beautify to format js, html, css
"   if &ft is# 'javascript' || &ft is# 'html' || &ft is# 'vue'
"     if executable('prettier')
"       exe '%!prettier ' .. args
"     else
"       call s:echo_err("prettier doesn't installed, please refference the https://github.com/beautify-web/js-beautify")
"     endif
"   elseif &ft is# 'css'
"     " TODO
"   elseif &ft is# 'json'
"     if executable('jq')
"       exe "%!jq " .. args
"     else
"       call s:echo_err("jq doesn't installed, please refference the https://stedolan.github.io/jq/")
"     endif
"   else
"     execute 'normal 1G=G'
"   endif

"   call setpos('.', pos)
" endfunction

" nnoremap <C-f> :call Format()<CR>
" " }}}



" " listの設定 {{{
" set list
" set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
" " }}}

" " {{{ 行末のホワイトスペース削除
" let s:spaces_target_ft = {
"       \ 'markdown': 0,
"       \ 'go': 1,
"       \ 'javascript': 1,
"       \ 'graphql': 1,
"       \ 'terminal': 1,
"       \ }
" augroup HighlightTrailingSpaces
"   au!
"   au BufWritePre * if get(s:spaces_target_ft, &ft, 0) | :silent keeppatterns %s/\s\+$//ge | endif
"   au VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
"   au VimEnter,WinEnter * if get(s:spaces_target_ft, &ft, 0) | match TrailingSpaces /\s\+$/ | endif
" augroup END
" " }}}

" " swapファイルを作成しない
" set noswapfile

" " {{{ セッションで保存する対象を設定する
" if !has('nvim')
"   set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize,terminal
" endif
" " }}}

" " ウィンドウサイズ自動調整を無効化
" "set noequalalways

" " 数値の加減算を考慮
" if has('patch-8.2.0860')
"   setglobal nrformats+=unsigned
" endif


" " key mappings {{{

" " fern
" nnoremap <silent> <Leader>f :Fern . -drawer<CR>
" augroup fern-setteings
"   au!
"   au FileType fern nnoremap <silent> q :bw!<CR>
" augroup END

" let g:fern#drawer_keep = 1

" " *でカーソルを移動しないようにする
" noremap * *N

" " 検索
" "nnoremap <C-G><C-G> :Ggrep <C-R><C-W><CR><CR>

" " 置換
" nnoremap <Leader>re :%s;\<<C-R><C-W>\>;g<Left><Left>;

" " ハイライトを削除する
" nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

" " テキストオブジェクトキーマッピング {{{
" onoremap 8 i(
" onoremap 2 i"
" onoremap 7 i'
" onoremap @ i`
" onoremap [ i[
" onoremap { i{

" onoremap a8 a(
" onoremap a2 a"
" onoremap a7 a'
" onoremap a@ a`
" onoremap a[ a[
" onoremap a{ a{

" " visual
" nnoremap v8 vi(
" nnoremap v2 vi"
" nnoremap v7 vi'
" nnoremap v@ vi`
" nnoremap v[ vi[
" nnoremap v{ vi{

" nnoremap va8 va(
" nnoremap va2 va"
" nnoremap va7 va'
" nnoremap va@ va`
" nnoremap va[ va[
" nnoremap va{ va{
" " }}}

" " numberとrelativenumberの切り替え
" nnoremap <silent> <Leader>n :set relativenumber!<CR>

" " ターミナル関連 {{{
" " ターミナルノーマルモード
" tnoremap <C-g>n <C-g>N

" " ターミナルでウィンドウ移動
" "tnoremap <silent> <C-n> <C-g>:tabnext<CR>
" "tnoremap <silent> <C-p> <C-g>:tabprevious<CR>

" " <c-g>を<c-w>代わりにする
" "tnoremap <C-g> <C-w>.

" " prefixキーを<C-g>に変更
" set termwinkey=<C-g>
" " }}}

" " review
" augroup review
"   au!
"   au FileType review vnoremap <silent> <buffer> <Leader>hi c@<cursor>{<c-r>"}<esc>
" augroup END

" " 改行
" nnoremap <C-j> o<ESC>
" nnoremap <C-k> O<ESC>
" nnoremap o A<CR>

" " 挿入モードでのカーソル移動
" inoremap <silent> <C-f> <Right>
" inoremap <silent> <C-b> <Left>
" inoremap <silent> <C-e> <Esc>A
" inoremap <silent> <C-a> <Esc>I

" " 囲う
" nnoremap <silent> gw[ cw``<Esc>P
" vnoremap <silent> gw[ c``<Esc>P

" " gina
" nnoremap <silent> gs :Gina status<CR>
" nnoremap <silent> gl :Gina log<CR>
" call gina#custom#mapping#nmap(
"       \ 'status', 'gp',
"       \ ':<C-u>Gina push<CR>',
"       \ {'noremap': 1, 'silent': 1},
"       \)
" call gina#custom#mapping#nmap(
"       \ 'status', 'cm',
"       \ ':<C-u>Gina commit<CR>',
"       \ {'noremap': 1, 'silent': 1},
"       \)
" call gina#custom#mapping#nmap(
"       \ 'status', 'ca',
"       \ ':<C-u>Gina commit --amend<CR>',
"       \ {'noremap': 1, 'silent': 1},
"       \)
" call gina#custom#mapping#nmap(
"       \ 'status', 'dp',
"       \ '<Plug>(gina-patch-oneside-tab)',
"       \ {'silent': 1},
"       \)
" call gina#custom#mapping#nmap(
"       \ 'status', 'q',
"       \ ':<C-u>bw!<CR>',
"       \ {'noremap': 1, 'silent': 1},
"       \)
" call gina#custom#mapping#nmap(
"       \ 'status', 'ga',
"       \ '--',
"       \ {'silent': 1},
"       \)
" call gina#custom#mapping#vmap(
"       \ 'status', 'ga',
"       \ '--',
"       \ {'silent': 1},
"       \)
" call gina#custom#mapping#nmap(
"       \ 'log', 'q',
"       \ ':<C-u>bw!<CR>',
"       \ {'noremap': 1, 'silent': 1},
"       \)
" call gina#custom#mapping#nmap(
"       \ 'log', 'dd',
"       \ '<Plug>(gina-changes-of)',
"       \ {'silent': 1},
"       \)
" call gina#custom#mapping#nmap(
"       \ 'changes', 'q',
"       \ ':<C-u>bw!<CR>',
"       \ {'noremap': 1, 'silent': 1},
"       \)

" " バッファ一覧
" nnoremap gb :Buffers<CR>

" " ヘルプ
" augroup help-mapping
"   au!
"   au FileType help nnoremap <buffer> <silent>q :bw!<CR>
" augroup END

" " }}}

" " コマンドラインで単語移動 {{{
" cnoremap <c-b> <Left>
" cnoremap <c-f> <Right>
" cnoremap <c-a> <Home>
" " }}}

" " vim-go settings {{{
" " ファイル保存時go importを実行する
" let g:go_fmt_command = 'goimports'

" " goplsを有効化
" let g:go_gopls_enabled = 0

" " ファイル保存時、linterを実行する
" "let g:go_metalinter_autosave = 1

" " linter実行時、go vetのみを実行する
" "let g:go_metalinter_autosave_enabled = ['vet']

" " golangci-lintを使う
" "let g:go_metalinter_command = "golangci-lint"

" " vim-lspを使用するので、vim-goの`Ctrl+]`を無効にする
" let g:go_def_mapping_enabled = 0

" " GoDocでポップアップウィンドウを使用する
" "let g:go_doc_popup_window = 1

" " GoRunやGoTest時の画面分割方法変更
" let g:go_term_mode = 'split'

" " テンプレート作成を無効化
" let g:go_template_autocreate = 0

" " すでに開いているバッファに定義ジャンプする
" let g:go_def_reuse_buffer = 1

" let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment']

" " key mapping
" augroup goMapping
"   au!
"   au FileType go set foldmethod=syntax
" augroup END
" " }}}

" " fzf settings {{{
" " ファイル一覧を出すときにプレビュー表示
" command! -bang -nargs=? -complete=dir Files
"       \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" nnoremap <C-P> :Files<CR>
" " }}}

" " lsp settings {{{
" function! s:on_lsp_buffer_enabled() abort
"   setlocal omnifunc=lsp#complete
"   set completeopt^=popup
"   nmap <Leader>ho <plug>(lsp-hover)
"   nnoremap <silent> <C-]> :LspDefinition<CR>

"   " enable signs
"   let g:lsp_signs_error = {'text': 'ｳﾎ'}
"   let g:lsp_signs_warning = {'text': '🍌'}
"   let g:lsp_signs_enabled = 1

"   "let g:lsp_log_verbose = 1
"   "let g:lsp_log_file = expand('~/vim-lsp.log')
" endfunction

" augroup lsp_install
"   au!
"   au User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
" augroup END
" " }}}

" " vim-markdown settings {{{
" " mdを開くときの折りたたみを無効にする
" let g:vim_markdown_folding_disabled = 1
" " }}}

" " profiling {{{
" " vim +'call ProfileCursorMove()' <カーソルを動かすのが重いファイル>
" function! ProfileCursorMove() abort
"   let profile_file = expand('./vim-profile.log')
"   if filereadable(profile_file)
"     call delete(profile_file)
"   endif

"   normal! ggzR

"   execute 'profile start ' . profile_file
"   profile func *
"   profile file *

"   augroup ProfileCursorMove
"     au!
"     au CursorHold <buffer> profile pause | q
"   augroup END

"   for i in range(1000)
"     call feedkeys('j')
"   endfor
" endfunction
" " }}}

" " emmet {{{
" let g:user_emmet_install_global = 0
" let g:user_emmet_settings = {
"       \   'variables': {
"       \     'lang' : 'ja'
"       \   }
"       \ }
" let g:user_emmet_leader_key = '<C-g>'

" augroup emmet
"   au!
"   au FileType vue,html,javascript,css EmmetInstall
"   au FileType vue,html,javascript,css imap <buffer> <C-f> <plug>(emmet-expand-abbr)
" augroup END
" " }}}

" " vim-vue {{{
" " https://github.com/posva/vim-vue#my-syntax-highlighting-stops-working-randomly
" " vueファイルのシンタックスが効かなくなる問題対応
" augroup VueSyntax
"   au!
"   au FileType vue syntax sync fromstart
" augroup END
" " }}}

" " sonictemplate.vim {{{
" let g:sonictemplate_author = 'skanehira'
" let g:sonictemplate_license = 'MIT'
" let g:sonictemplate_vim_template_dir = expand('~/.vim/sonictemplate')
" imap <silent> <C-l> <plug>(sonictemplate-postfix)
" " }}}

" " vimhelpgenarator {{{
" let g:vimhelpgenerator_version = ''
" let g:vimhelpgenerator_author = 'Author: skanehira <sho19921005@gmail.com>'
" let g:vimhelpgenerator_uri = 'https://github.com/skanehira/'
" let g:vimhelpgenerator_defaultlanguage = 'en'
" " }}}

" " {{{ MemoList
" let g:memolist_fzf = 1
" " }}}

" " {{{ lexima
" let g:lexima_enable_basic_rules = 1
" " }}}

" " {{{ docker.vim
" " let g:docker_terminal_open = 'vert'
" "let s:docker_auth_file = expand('~/.docker/docker.vim.json')
" "let g:docker_registry_auth = json_decode(join(readfile(s:docker_auth_file), "\n"))
" " }}}

" " {{{ preview.vim
" let g:previm_open_cmd = 'open'
" " }}}

" " {{{ gofmtmd
" let g:gofmtmd_auto_fmt = 0
" " }}}

" " {{{ preview-markdown.vim
" let g:preview_markdown_vertical = 1
" let g:preview_markdown_auto_update = 1
" let g:preview_markdown_parser = 'mdr'
" " }}}

" " {{{ vista
" let g:vista_default_executive = 'vim_lsp'
" " }}}

" "{{{ gist-vim
" let g:gist_post_private = 1
" let g:gist_list_vsplit = 1
" "}}}

" " {{{ 自作関数

" " {{{ w3m
" function! s:gg(package) abort
"   execute('term ++close ++shell w3m pkg.go.dev/' . a:package)
" endfunction

" command! -nargs=1 GG call s:gg(<f-args>)

" function! s:www(word) abort
"   execute('term ++close ++shell w3m google.com/search\?q="' . a:word . '"')
" endfunction

" command! -nargs=1 WWW call s:www(<f-args>)
" " }}}

" " {{{ リポジトリに移動
" function! s:cd_repo(shell, repo) abort
"   exe 'lcd' trim(system('ghq root')) .. '/' .. a:repo
"   pwd
" endfunction

" function! s:repo(cb) abort
"   if executable('ghq') && exists('*fzf#run()') && executable('fzf')
"     call fzf#run({
"           \ 'source': systemlist('ghq list'),
"           \ 'sink': a:cb,
"           \ 'down': '40%'},
"           \ )
"   else
"     echo "doesn't installed ghq or fzf.vim(require fzf)"
"   endif
" endfunction

" command! Repo call s:repo(function('s:cd_repo', [&shell]))
" " }}}

" " 新しいタブを開く {{{
" function! s:open_tabs(shell, repo) abort
"   exe printf('tabnew | lcd %s/%s', trim(system('ghq root')), a:repo)
" endfunction

" " fzf.vimのcallbackでは&shellがshになってしまうので、現在実行しているshellを渡す
" command! Repot call s:repo(function('s:open_tabs', [&shell]))

" " }}}

" " {{{ エラーメッセージ出力
" function! s:echo_err(message) abort
"   echohl ErrorMsg
"   redraw
"   echo a:message
"   echohl None
" endfunction
" " }}}

" " {{{ gitコマンド関連
" " options:
" " {
" "	cmd: 'diff'
" "	args: [
" "		'HEAD^',
" "	],
" "	auto_close: 0,	" 1: true, 0: false
" "	window_way: 'bo',	" tab, bo, vert, term, etc...
" "	mode: 'term', " term, popup, fzf
" "	focus: 1008, " window id
" "	source: [], " fzf source
" "	cb: functionm "fzf callback
" " }
" function! s:git_exec(opt) abort
"   let current_winid = win_getid()
"   if a:opt.mode is# 'term'
"     let cmd = 'git ' .. a:opt.cmd
"     if has_key(a:opt, 'args') && !empty(a:opt.args)
"       let cmd = cmd .. ' ' .. join(a:opt.args, ' ')
"     endif
"     if has_key(a:opt, 'auto_close') && a:opt.auto_close is# 1
"       let cmd = a:opt.window_way .. ' term ++rows=10 ++close ' .. cmd
"     else
"       let cmd = a:opt.window_way .. ' term ++rows=10 ' .. cmd
"     endif
"     exec cmd
"     nnoremap <buffer> <silent> q :bw!<CR>
"   elseif a:opt.mode is# 'pop'
"     " TODO use popup window
"   elseif a:opt.mode is# 'fzf'
"     if exists('*fzf#run()') && executable('fzf')
"       call fzf#run({
"             \ 'source': a:opt.source,
"             \ 'sink': a:opt.cb,
"             \ 'down': '40%'},
"             \ )
"     endif
"   else
"     call s:echo_err("doesn't installed fzf.vim(require fzf)")
"   endif

"   call win_gotoid(current_winid)
" endfunction

" function! s:git_log() abort
"   " use fish command
"   call system('tmux new-window git log')
" endfunction

" function! s:git_push(...) abort
"   let opt = {
"         \ 'cmd': 'push',
"         \ 'args': a:000,
"         \ 'auto_close': 1,
"         \ 'window_way': 'top',
"         \ 'mode': 'term',
"         \ }

"   call s:git_exec(opt)
" endfunction

" function! s:git_pull(...) abort
"   let opt = {
"         \ 'cmd': 'pull',
"         \ 'args': a:000,
"         \ 'auto_close': 1,
"         \ 'window_way': 'top',
"         \ 'mode': 'term',
"         \ }

"   call s:git_exec(opt)
" endfunction

" function! s:git_checkout_cb(repo) abort
"   call system('git checkout' .. a:repo)
" endfunction

" function! s:git_checkout(...) abort
"   let source = filter(systemlist('git branch'), 'v:val[0] isnot# "*"')
"   if empty(source)
"     call s:echo_err("no other branch")
"     return
"   endif

"   let opt = {
"         \ 'source': source,
"         \ 'mode': 'fzf',
"         \ 'cb': function('s:git_checkout_cb'),
"         \ }

"   call s:git_exec(opt)
" endfunction

" command! -nargs=* Gitpush call s:git_push(<f-args>)
" command! -nargs=* Gitpull call s:git_pull()
" command! -nargs=* Gitblame call s:git_blame()
" command! -nargs=* GitCheckout call s:git_checkout(<f-args>)
" command! Lazygit call system('tmux new-window lazygit')

" nnoremap <silent> gc :GitCheckout<CR>

" " }}}

" " {{{ バッファ関連
" function! s:buflist() abort
"   return filter(range(1, bufnr('$')), 'buflisted(v:val) && getbufvar(v:val, "&filetype") != "qf"')
" endfunction

" function! s:format_buffer(b)
"   let name = bufname(a:b)
"   let name = empty(name) ? '[No Name]' : fnamemodify(name, ":p:~:.")
"   let flag = a:b == bufnr('')  ? '%' : a:b == bufnr('#') ? '#' : ' '
"   let modified = getbufvar(a:b, '&modified') ? ' [+]' : ''
"   let readonly = getbufvar(a:b, '&modifiable') ? '' : ' [RO]'
"   let extra = join(filter([modified, readonly], '!empty(v:val)'), '')
"   return printf("[%s] %s\t%s\t%s", a:b, flag, name, extra)
" endfunction

" function! s:delbuf(buf) abort
"   exe 'bw!' a:buf[match(a:buf, '[')+1:match(a:buf, ']')-1]
" endfunction

" function! s:delbuflist() abort
"   call fzf#run({
"         \ 'source': map(copy(s:buflist()), 's:format_buffer(v:val)'),
"         \ 'sink': function('s:delbuf'),
"         \ 'options': "-m",
"         \ 'down': '40%'},
"         \ )
" endfunction

" command! DelBuf call s:delbuflist()
" " }}}

" " {{{ ディレクトリ自動生成
" augroup vimrc-auto-mkdir
"   au!
"   au BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
"   function! s:auto_mkdir(dir, force)
"     if !isdirectory(a:dir) && (a:force ||
"           \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
"       call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
"     endif
"   endfunction
" augroup END
" " }}}

" " }}}

" " vim: foldmethod=marker

" if has("unix")
"   let s:uname = system("uname -s")
"   " Do Mac stuff
"   if s:uname == "Darwin\n"
"     source ~/.osx.vimrc
"   endif
" endif
" source ~/.maps.vimrc
" source ~/.lightline.vimrc
