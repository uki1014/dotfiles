local maps = require('maps')

maps.nmap('<Leader>co', ':call coc#util#install()<CR>', maps.n)
maps.nmap('<Leader>col', ':CocOpenLog<CR>', maps.n)
-- maps.nmap('<Esc>', ':call coc#float#close_all()', maps.n)
maps.nmap('<Leader>cre', ':call coc#refresh()<CR>', maps.n)

-- Remap keys for gotos
maps.nmap('gd', '<Plug>(coc-definition)', maps.s)
maps.nmap('gy', '<Plug>(coc-type-definition)', maps.s)
maps.nmap('gi', '<Plug>(coc-implementation)', maps.s)
maps.nmap('gr', '<Plug>(coc-references)', maps.s)
maps.nmap('K', ':lua show_documentation()<CR>', maps.ns)


-- Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
-- Coc only does snippet and additional edit on confirm.
vim.api.nvim_set_keymap('i', '<CR>', 'pumvisible() ? "<C-y>" : "<C-g>u<CR>"', maps.ne)

-- Use tab for trigger completion with characters ahead and navigate.
--Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
-- vim.api.nvim_set_keymap('i', '<TAB>', 'pumvisible() ? "<C-n>" : <SID>check_back_space() ? "<TAB>" : coc#refresh()', { noremap = true, silent = true, expr = true })
-- vim.api.nvim_set_keymap('i', '<S-TAB>', 'pumvisible() ? "<C-p>" : "<C-h>"', { expr = true })

vim.cmd('let coc_path = globpath(&rtp, "autoload/coc.vim")')
if not vim.fn.empty(coc_path) then
  function coc_configure_and_start()
    vim.g.coc_user_config = {}
    vim.g.coc_user_config['coc.preferences.jumpCommand'] = ':SplitIfNotOpen4COC'
  end
end

function check_back_space()
  local col = vim.fn.col('.') - 1
  if col == 0 or fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

function show_documentation()
  if vim.fn.index({"vim","help"}, filetype) >= 0 then
    vim.cmd('h'.. vim.fn.expand('<cword>'))
  else
    vim.fn.CocAction('doHover')
  end
end

--Highlight symbol under cursor on CursorHold
vim.cmd('au CursorHold * silent call CocActionAsync("highlight")')

vim.cmd('augroup mygroup')
vim.cmd('au!')
-- Setup formatexpr specified filetype(s).
vim.cmd('au FileType typescript,json setl formatexpr=CocAction("formatSelected")')
-- Update signature help on jump placeholder
vim.cmd('au User CocJumpPlaceholder call CocActionAsync("showSignatureHelp")')
vim.cmd('augroup END')

-- coc-cssでscssファイルにおいて@をkeywordとして登録する
vim.cmd('au FileType scss setl iskeyword+=@-@')

-- Add status line support, for integration with other plugin, checkout `:h coc-status`
-- set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

--coc-eslint
vim.cmd("au BufNewFile,BufReadPre,BufEnter *.{flow,config.js,config.copy.js,config.lib.js,config.style.js,config.proxy.js} call coc#config('eslint.enable', v:false)")
vim.cmd("au BufLeave *.{js,jsx,ts,tsx} call coc#config('eslint.enable', v:true)")

-- Extensions
vim.g.coc_global_extensions = {
  'coc-tsserver',
  'coc-flow',
  'coc-prettier',
  'coc-eslint',
  'coc-solargraph',
  'coc-css',
  'coc-sh',
  'coc-tabnine',
  'coc-cssmodules',
  'coc-styled-components',
  'coc-vimlsp',
  'coc-prisma'
}


-- Prettier
vim.cmd('command! -nargs=0 Prettier :CocCommand prettier.formatFile')
