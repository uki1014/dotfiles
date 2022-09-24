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
    dir_icon = "",
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

maps.nmap(';f', function()
  builtin.find_files({
    find_command = rg,
    ignore_case = true,
    hidden = true,
  })
end, maps.ns)
maps.nmap(';r', function()
  builtin.live_grep({
    find_command = rg,
    ignore_case = true,
    hidden = true,
  })
end, maps.ns)
maps.nmap(';;', function()
  builtin.grep_string({
    find_command = rg,
    ignore_case = true,
    hidden = true,
  })
end, maps.ns)
maps.nmap(';m', function() builtin.resume() end, maps.ns)
maps.nmap(';c', function() builtin.command_history() end, maps.ns)
maps.nmap(';e', function() builtin.buffers() end, maps.ns)
maps.nmap(';t', function() builtin.man_pages() end, maps.ns)
maps.nmap(';g', function() builtin.git_status() end, maps.ns)

-- only ruby
maps.nmap(';h', function()
  builtin.find_files({
    find_command = rg,
    ignore_case = true,
    hidden = true,
    type = ruby
  })
end, maps.ns)
maps.nmap(';hr', function()
  builtin.live_grep({
    find_command = rg,
    ignore_case = true,
    hidden = true,
    additional_args = function() return { '--type=ruby' } end
  })
end, maps.ns)

-- ignore spec directory
maps.nmap(';w', function()
  builtin.find_files({
    find_command = rg,
    ignore_case = true,
    hidden = true,
    type = ruby,
    glob = '!spec',
  })
end, maps.ns)
maps.nmap(';wr', function()
  builtin.live_grep({
    find_command = rg,
    ignore_case = true,
    hidden = true,
    glob = '!spec',
    additional_args = function() return { '--type=ruby' } end
  })
end, maps.ns)

-- only javascript / typescript
maps.nmap(';j', function()
  builtin.find_files({
    find_command = rg,
    ignore_case = true,
    hidden = true,
    type = { 'js', 'ts' }
  })
end, maps.ns)
maps.nmap(';jr', function()
  builtin.live_grep({
    find_command = rg,
    ignore_case = true,
    hidden = true,
    additional_args = function() return { '--type=js', '--type=ts' } end
  })
end, maps.ns)

-- Telescope-file-browser
maps.nmap('sf', function() open_file_browser('normal') end, maps.n)

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
