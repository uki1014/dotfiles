local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local file_browser_actions = telescope.extensions.file_browser.actions

local function telescope_buffer_dir()
	return vim.fn.expand("%:p:h")
end

telescope.setup({
	defaults = {
		initial_mode = "insert",
		-- sorting_strategy = "ascending",
		mappings = {
			i = {
				["<Down>"] = actions.cycle_history_next,
				["<Up>"] = actions.cycle_history_prev,
			},
			n = {
				["q"] = actions.close,
			},
		},
		layout_config = {
			width = 180,
			height = 40,
		},
	},
	extensions = {
		file_browser = {
			sorting_strategy = "ascending",
			previewer = false,
			layout_config = {
				width = 100,
				height = 30,
			},
			hijack_netrw = true,
			dir_icon = {},
			mappings = {
				n = {
					["N"] = file_browser_actions.create,
					["h"] = file_browser_actions.goto_parent_dir,
				},
			},
		},
	},
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
		dir_icon = "▸",
		-- layout_config = { width = 200, height = 50 },
	})
end

local function find_files()
	builtin.find_files({
		find_command = rg,
		ignore_case = true,
		hidden = true,
	})
end

Maps.nmap(";f", function()
	find_files()
end, Maps.ns)
Maps.nmap(";r", function()
	builtin.live_grep({
		find_command = "rg",
		ignore_case = true,
		hidden = true,
	})
end, Maps.ns)
Maps.nmap(";;", function()
	builtin.grep_string({
		find_command = "rg",
		ignore_case = true,
		hidden = true,
	})
end, Maps.ns)
Maps.nmap(";g", function()
	builtin.git_status({
		initial_mode = "normal",
	})
end, Maps.ns)

-- Telescope-file-browser
Maps.nmap("sf", function()
	open_file_browser("normal")
end, Maps.n)

-- tab
Maps.nmap("te", function()
	vim.cmd("tabedit")
	find_files()
end, Maps.n)
-- Tabs
Maps.nmap("fl", ":tabnext<Return>", Maps.s)
Maps.nmap("fj", ":tabprev<Return>", Maps.s)
