local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

treesitter.setup({
	highlight = {
		enable = false,
		disable = {},
	},
	indent = {
		enable = true,
		disable = {},
	},
	ensure_installed = {
		"toml",
		"fish",
		"php",
		"json",
		"yaml",
		"css",
		"html",
		"lua",
		"ruby",
		"javascript",
		"typescript",
		"tsx",
		"proto",
		"lua",
		"python",
		"scss",
		"prisma",
		"markdown",
	},
	matchup = {
		enable = true,
	},
	endwise = {
		enable = true,
	},
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = {
	"javascript",
	"javascript.jsx",
	"javascriptreact",
	"typescript",
	"typescript.tsx",
	"typescriptreact",
}
