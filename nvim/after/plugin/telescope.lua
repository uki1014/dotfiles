local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local file_browser_actions = telescope.extensions.file_browser.actions

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

telescope.setup({
  defaults = {
    initial_mode = 'insert',
    mappings = {
      i = {
        ['<Down>'] = actions.cycle_history_next,
        ['<Up>'] = actions.cycle_history_prev,
      },
      n = {
        ['q'] = actions.close
      },
    },
  },
  extensions = {
    file_browser = {
      theme = 'dropdown',
      layout_config = {
        width = 150,
        height = 50
      },
      hijack_netrw = true,
      mappings = {
        n = {
          ["N"] = file_browser_actions.create,
          ['h'] = file_browser_actions.goto_parent_dir,
        }
      }
    }
  }
})

telescope.load_extension("file_browser")

local function open_file_browser(initial_mode)
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    all_previewer = true,
    initial_mode = initial_mode,
    select_buffer = true,
    dir_icon = '▸',
    -- layout_config = { width = 200, height = 50 },
  })
end

Maps.nmap(';f', function()
  builtin.find_files({
    find_command = rg,
    ignore_case = true,
    hidden = true,
  })
end, Maps.ns)
Maps.nmap(';r', function()
  builtin.live_grep({
    find_command = 'rg',
    ignore_case = true,
    hidden = true,
  })
end, Maps.ns)
Maps.nmap(';;', function()
  builtin.grep_string({
    find_command = 'rg',
    ignore_case = true,
    hidden = true,
  })
end, Maps.ns)
Maps.nmap(';m', function() builtin.resume() end, Maps.ns)
Maps.nmap(';c', function() builtin.command_history() end, Maps.ns)
Maps.nmap(';e', function() builtin.buffers() end, Maps.ns)
Maps.nmap(';t', function() builtin.man_pages() end, Maps.ns)
Maps.nmap(';g', function() builtin.git_status() end, Maps.ns)

-- only ruby
Maps.nmap(';h', function()
  builtin.find_files({
    find_command = 'rg',
    ignore_case = true,
    hidden = true,
    type = 'ruby'
  })
end, Maps.ns)
Maps.nmap(';hr', function()
  builtin.live_grep({
    find_command = 'rg',
    ignore_case = true,
    hidden = true,
    additional_args = function() return { '--type=ruby' } end
  })
end, Maps.ns)

-- ignore spec directory
Maps.nmap(';w', function()
  builtin.find_files({
    find_command = 'rg',
    ignore_case = true,
    hidden = true,
    type = 'ruby',
    glob = '!spec',
  })
end, Maps.ns)
Maps.nmap(';wr', function()
  builtin.live_grep({
    find_command = 'rg',
    ignore_case = true,
    hidden = true,
    glob = '!spec',
    additional_args = function() return { '--type=ruby' } end
  })
end, Maps.ns)

-- only javascript / typescript
Maps.nmap(';j', function()
  builtin.find_files({
    find_command = 'rg',
    ignore_case = true,
    hidden = true,
    type = { 'js', 'ts' }
  })
end, Maps.ns)
Maps.nmap(';jr', function()
  builtin.live_grep({
    find_command = 'rg',
    ignore_case = true,
    hidden = true,
    additional_args = function() return { '--type=js', '--type=ts' } end
  })
end, Maps.ns)

-- Telescope-file-browser
Maps.nmap('sf', function() open_file_browser('normal') end, Maps.n)

-- tab
Maps.nmap(
  'te',
  function()
    vim.cmd('tabedit')
    open_file_browser('insert')
  end,
  Maps.n
)
-- Tabs
Maps.nmap('fl', ':tabnext<Return>', Maps.s)
Maps.nmap('fj', ':tabprev<Return>', Maps.s)
