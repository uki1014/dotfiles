local maps = require('maps')
local telescope = require('telescope')

maps.nmap(';f', ':Telescope find_files find_command=rg,--ignore-case,--hidden,--files<CR>', maps.ns)
maps.nmap(';r', ':Telescope live_grep find_command=rg,--ignore-case,--hidden,--files<CR>', maps.ns)
maps.nmap(';;', ':Telescope grep_string find_command=rg,--ignore-case,--hidden,--files<CR>', maps.ns)
maps.nmap(';t', ':lua require("telescope.builtin").command_history{}<CR>', maps.ns)
maps.nmap(';c', ':lua require("telescope.builtin").commands{}<CR>', maps.ns)
maps.nmap(';e', ':Telescope buffers<CR>', maps.ns)

-- only ruby
maps.nmap(';h', ':Telescope find_files find_command=rg,--ignore-case,--hidden,--files,--type=ruby<CR>', maps.ns)
maps.nmap(';hr', ':lua require("telescope.builtin").live_grep({ additional_args = function() return { "--type=ruby" } end })<CR>', maps.ns)

-- ignore spec directory
maps.nmap(';w', ':Telescope find_files find_command=rg,--ignore-case,--hidden,--files,--type=ruby,--glob=!spec<CR>', maps.ns)
maps.nmap(';wr', ':lua require("telescope.builtin").live_grep({ additional_args = function() return { "--type=ruby", "--glob=!spec" } end })<CR>', maps.ns)

-- only javascript / typescript
maps.nmap(';j', ':Telescope find_files find_command=rg,--ignore-case,--hidden,--files,--type=js,--type=ts<CR>', maps.ns)
maps.nmap(';jr', ':lua require("telescope.builtin").live_grep({ additional_args = function() return { "--type=js", "--type=ts" } end })<CR>', maps.ns)

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
