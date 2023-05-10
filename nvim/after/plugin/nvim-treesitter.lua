local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

treesitter.setup({
	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,
	build = ":TSUpdate",
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
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
		-- "php",
		"json",
		"yaml",
		"css",
		"html",
		"lua",
		-- "ruby",
		"javascript",
		"typescript",
		"tsx",
		"proto",
		"python",
		"scss",
		"prisma",
		"markdown",
		"astro",
		"graphql",
		"svelte",
		"vim",
		-- "vue",
	},
	matchup = {
		enable = true,
	},
	endwise = {
		enable = true,
	},
	autotag = {
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
