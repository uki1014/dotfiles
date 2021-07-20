local opt = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', ';r', ':<C-u>Dgrep<CR>', opt)
vim.api.nvim_set_keymap('n', ';;', ':<C-u>DeniteCursorWord grep:.<CR>', opt)
vim.api.nvim_set_keymap('n', ';f', ':<C-u>Denite file/rec -start-filter<CR>', opt)
vim.api.nvim_set_keymap('n', ';gr', ':<C-u>Denite command command_history<CR>', opt)
vim.api.nvim_set_keymap('n', ';e', ':<C-u>Denite -resume<CR>', opt)

vim.cmd('augroup denite_filter')
vim.cmd('au FileType denite lua denite_my_settings()')
function denite_my_settings()
  local opt = { noremap = true, silent = true, expr = true }
  vim.api.nvim_buf_set_keymap(0, 'n', '<CR>', 'denite#do_map("do_action")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'l', 'denite#do_map("do_action", "vsplit")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', '<Space>', 'denite#do_map("do_action", "split")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'd', 'denite#do_map("do_action", "delete")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'p', 'denite#do_map("do_action", "preview")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'q', 'denite#do_map("quit")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 'i', 'denite#do_map("open_filter_buffer")', opt)
  vim.api.nvim_buf_set_keymap(0, 'n', 't', 'denite#do_map("toggle_select")."j"', opt)
  vim.api.nvim_buf_set_keymap(0, 'i', '<C-n>', '<Plug>(denite_filter_quit)<DOWN>', { silent = true })
  vim.api.nvim_buf_set_keymap(0, 'i', '<C-p>', '<Plug>(denite_filter_quit)<UP>', { silent = true })
  vim.api.nvim_buf_set_keymap(0, 'i', '<CR>', '<Plug>(denite_filter_quit)<CR>', { silent = true })
end
vim.cmd('augroup END')

denite_win_width_percent = 0.8
denite_win_height_percent = 0.7
denite_default_options = {
  split = 'floating',
  winwidth = math.ceil(vim.o.columns * denite_win_width_percent),
  wincol = math.ceil((vim.o.columns - (vim.o.columns * denite_win_width_percent)) / 2),
  winheight = math.ceil(vim.o.lines * denite_win_height_percent),
  winrow = math.ceil((vim.o.lines - (vim.o.lines * denite_win_height_percent)) / 2),
  highlight_filter_background = 'DeniteFilter',
  prompt = '> ',
}

denite_option_array = {}
for key, value in pairs(denite_default_options) do
  if value ~= nil then
    table.insert(denite_option_array, '-'..key..'='..value)
  end
end

vim.fn['denite#custom#option']('default', denite_default_options)

-- ripgrep
vim.fn['denite#custom#var']('file/rec', 'command', {
  'rg',
  '--files',
  '--ignore-case',
  '--hidden',
  '--glob',
  '!.git',
  '--color',
  'never'
})

-- Ripgrep command on grep source
vim.fn['denite#custom#var']('grep', {
  command = { 'rg' },
  default_opts = { '-i', '--vimgrep', '--no-heading' },
  recursive_opts = {},
  pattern_opt = { '--regexp' },
  separator = { '--' },
  final_opts = {},
})

vim.fn['denite#custom#source']('file/rec', 'matchers', { 'matcher/substring' })
vim.cmd('command! -nargs=? Dgrep lua Dgrep(<f-args>)')

function Dgrep(...)
  local args = { ... }
  if #args > 0 then
    vim.cmd(':Denite -buffer-name=grep-buffer-denite grep -path='..args[1])
  else
    -- Projectのルートを基準にgrep
    vim.cmd(':DeniteProjectDir -buffer-name=grep-buffer-denite -no-empty '..table.concat(denite_option_array, ' ')..' grep')
  end
end
