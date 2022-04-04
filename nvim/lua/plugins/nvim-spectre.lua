local opt = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<Leader>m', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', opt)
vim.api.nvim_set_keymap('n', '<Leader>w', '<cmd>lua require("spectre").open_visual()<CR>', opt)

require('spectre').setup()

