vim.api.nvim_set_keymap('n', ';sf', ":<C-u>Defx -listed -resume -columns=indent:mark:icon:icons:filename:git:size -buffer-name=tab`tabpagenr()` -search=`expand('%:p')` `expand('%:p:h')`<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', ';fs', ":<C-u>Defx -new -columns=indent:mark:icon:icons:filename:git:size -buffer-name=tab`tabpagenr()` -search=`expand('%:p')` `expand('%:p:h')`<CR>", { noremap = true, silent = true })

function defx_settings()
  opt = { noremap = true, silent = true, expr = true }
  vim.api.nvim_buf_set_keymap(0, 'n', '<CR>', 'defx#do_action("open")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'c', 'defx#do_action("copy")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'm', 'defx#do_action("move")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'p', 'defx#do_action("paste")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'l', 'defx#do_action("open")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'L', 'defx#do_action("open", "tabnew")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'E', 'defx#do_action("open", "vsplit")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'P', 'defx#do_action("open", "pedit")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'J', 'defx#do_action("open_or_close_tree")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'K', 'defx#do_action("new_directory")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'N', 'defx#do_action("new_file")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'M', 'defx#do_action("new_multiple_files")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'C', 'defx#do_action("toggle_columns", "mark:indent:icon:filename:type:size:time")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'S', 'defx#do_action("toggle_sort", "time")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'd', 'defx#do_action("remove")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'r', 'defx#do_action("rename")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', '!', 'defx#do_action("execute_command")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'x', 'defx#do_action("execute_system")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'yy', 'defx#do_action("yank_path")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', '.', 'defx#do_action("toggle_ignored_files")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', ';', 'defx#do_action("repeat")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'h', 'defx#do_action("cd", [".."])', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', '~', 'defx#do_action("cd")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'q', 'defx#do_action("quit")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', '<Space>', 'defx#do_action("toggle_select")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', '*', 'defx#do_action("toggle_select_all")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'j', 'line(".") == line("$") ? "gg" : "j"', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'k', 'line(".") == 1 ? "G" : "k"', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', '<C-l>', 'defx#do_action("redraw")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', '<C-g>', 'defx#do_action("print")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'cd', 'defx#do_action("change_vim_cwd")', opt)
end

vim.fn['defx#custom#column']('icon', {
  directory_icon = '▸',
  opened_icon = '▾',
  root_icon = ' ',
})

vim.fn['defx#custom#column']('git', 'indicators', {
  Modified = 'M',
  Staged = '✚',
  Untracked = '✭',
  Renamed = '➜',
  Unmerged = '═',
  Ignored = '☒',
  Deleted = '✖',
  Unknown = '?'
})

-- 隠しファイルを表示させる
-- show_ignored_filesを0にしてignored_filesを指定すると指定されたファイルのみignoreされるぽい
vim.fn['defx#custom#option']('_', {
  show_ignored_files = '0',
  ignored_files = '.DS_Store'
})

vim.cmd('autocmd FileType defx call v:lua.defx_settings()')
