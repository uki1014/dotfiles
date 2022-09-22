local opt = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', ';f', ':Telescope find_files find_command=rg,--ignore-case,--hidden,--files<CR>', opt)
vim.api.nvim_set_keymap('n', ';r', ':Telescope live_grep find_command=rg,--ignore-case,--hidden,--files<CR>', opt)
vim.api.nvim_set_keymap('n', ';;', ':Telescope grep_string find_command=rg,--ignore-case,--hidden,--files<CR>', opt)
vim.api.nvim_set_keymap('n', ';t', ':lua require("telescope.builtin").command_history{}<CR>', opt)
vim.api.nvim_set_keymap('n', ';c', ':lua require("telescope.builtin").commands{}<CR>', opt)
vim.api.nvim_set_keymap('n', ';e', ':Telescope buffers<CR>', opt)

-- only ruby
vim.api.nvim_set_keymap('n', ';h', ':Telescope find_files find_command=rg,--ignore-case,--hidden,--files,--type=ruby<CR>', opt)
vim.api.nvim_set_keymap('n', ';hr', ':lua require("telescope.builtin").live_grep({ additional_args = function() return { "--type=ruby" } end })<CR>', opt)

-- ignore spec directory
vim.api.nvim_set_keymap('n', ';w', ':Telescope find_files find_command=rg,--ignore-case,--hidden,--files,--type=ruby,--glob=!spec<CR>', opt)
vim.api.nvim_set_keymap('n', ';wr', ':lua require("telescope.builtin").live_grep({ additional_args = function() return { "--type=ruby", "--glob=!spec" } end })<CR>', opt)

-- only javascript / typescript
vim.api.nvim_set_keymap('n', ';j', ':Telescope find_files find_command=rg,--ignore-case,--hidden,--files,--type=js,--type=ts<CR>', opt)
vim.api.nvim_set_keymap('n', ';jr', ':lua require("telescope.builtin").live_grep({ additional_args = function() return { "--type=js", "--type=ts" } end })<CR>', opt)

local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    initial_mode = 'insert',
    mappings = {
      n = {
        ['q'] = actions.close
      },
    },
  }
}
