local opt = { noremap = true, silent = true }

-- Grep files
vim.api.nvim_set_keymap('n', ';f', ':Telescope find_files find_command=rg,--ignore-case,--hidden,--files<CR>', opt)
-- Grep string
vim.api.nvim_set_keymap('n', ';r', ':Telescope live_grep find_command=rg,--ignore-case,--hidden,--files<CR>', opt)
-- ?Searches for the string under my cursor in current working directory
vim.api.nvim_set_keymap('n', ';;', ':Telescope grep_string find_command=rg,--ignore-case,--hidden,--files<CR>', opt)
-- vim command history
vim.api.nvim_set_keymap('n', ';t', ':lua require"telescope.builtin".command_history{}<CR>', opt)
-- 現環境で使えるCommandのリスト
vim.api.nvim_set_keymap('n', ';c', ':lua require"telescope.builtin".commands{}<CR>', opt)
vim.api.nvim_set_keymap('n', ';e', ':Telescope buffers<CR>', opt)
vim.api.nvim_set_keymap('n', ';g', ':Telescope help_tags<CR>', opt)
-- builtin command lists
vim.api.nvim_set_keymap('n', ';b', ':lua require"telescope.builtin".builtin{}<CR>', opt)

local actions = require('telescope.actions')
-- Global remapping
------------------------------
require('telescope').setup{
  defaults = {
    initial_mode = "insert",
    mappings = {
      n = {
        ['q'] = actions.close
      },
    },
  }
}
