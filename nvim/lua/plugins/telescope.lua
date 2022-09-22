local maps = require('maps')
local telescope = require('telescope')
local telescope_actions = require('telescope.actions')
local file_browser_actions = telescope.extensions.file_browser.actions

telescope.load_extension("file_browser")

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local function open_file_browser(initial_mode)
  telescope.extensions.file_browser.file_browser({
    dir_icon = "",
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = false,
    grouped = true,
    all_previewer = true,
    initial_mode = initial_mode,
    select_buffer = true,
    dir_icon = '▸',
    -- layout_config = { width = 200, height = 50 },
  })
end

maps.nmap(';f', ':Telescope find_files find_command=rg,--ignore-case,--hidden,--files<CR>', maps.ns)
maps.nmap(';r', ':Telescope live_grep find_command=rg,--ignore-case,--hidden,--files<CR>', maps.ns)
maps.nmap(';;', ':Telescope grep_string find_command=rg,--ignore-case,--hidden,--files<CR>', maps.ns)
maps.nmap(';t', ':lua require("telescope.builtin").resume()<CR>', maps.ns)
maps.nmap(';c', ':lua require("telescope.builtin").command_history{}<CR>', maps.ns)
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

-- Telescope-file-browser
maps.nmap(
  'sf',
  function() open_file_browser('normal') end,
  maps.n
)

-- tab
maps.nmap(
  'te',
  function()
    vim.cmd('tabedit')
    open_file_browser('insert')
  end,
  maps.n
)
-- Tabs
maps.nmap('fl', ':tabnext<Return>', maps.s)
maps.nmap('fj', ':tabprev<Return>', maps.s)

telescope.setup({
  defaults = {
    initial_mode = 'insert',
    mappings = {
      i = {
        ['<Down>'] = telescope_actions.cycle_history_next,
        ['<Up>'] = telescope_actions.cycle_history_prev,
      },
      n = {
        ['q'] = telescope_actions.close
      },
    },
  },
  extensions = {
    file_browser = {
      hijack_netrw = true,
      mappings = {
        n = {
          ['h'] = file_browser_actions.goto_parent_dir,
        }
      }
    }
  }
})
