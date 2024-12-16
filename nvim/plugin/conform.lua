local conform = require("conform")
local util = require("conform.util")

local function biome_lsp_or_prettier()
	local has_prettier = vim.fs.find({
		-- https://prettier.io/docs/en/configuration.html
		".prettierrc",
		".prettierrc.json",
		".prettierrc.yml",
		".prettierrc.yaml",
		".prettierrc.json5",
		".prettierrc.js",
		".prettierrc.cjs",
		".prettierrc.toml",
		"prettier.config.js",
		"prettier.config.cjs",
	}, { upward = true })[1]
	if has_prettier then
		local has_eslint = vim.fs.find({
			".eslintrc",
			".eslintrc.js",
			".eslintrc.cjs",
			".eslintrc.json",
			"eslintrc.js",
			"eslintrc.json",
			"eslint.config.js",
			"eslint.config.cjs",
			"eslintrc.ts",
		}, { upward = true })[1]
		if has_eslint then
			return { "prettierd", "eslint_d", "lsp" }
		end
		return { "prettierd", "lsp" }
	end
	return { "biome" }
end

local eslint_d = require("conform.formatters.eslint_d")
eslint_d.cwd = util.root_file({
	".eslintrc",
	".eslintrc.js",
	".eslintrc.json",
	"eslintrc.js",
	"eslintrc.json",
})

conform.setup({
	log_level = vim.log.levels.DEBUG,
	formatters_by_ft = {
		lua = { "stylua" },
		json = biome_lsp_or_prettier,
		javascript = biome_lsp_or_prettier,
		javascriptreact = biome_lsp_or_prettier,
		typescript = biome_lsp_or_prettier,
		typescriptreact = biome_lsp_or_prettier,
		astro = biome_lsp_or_prettier,
	},
	format_on_save = {
		timeout_ms = 2000,
		lsp_fallback = true,
	},
	formatters = {
		eslint_d = {
			format_on_save = {
				timeout_ms = 20000,
				lsp_fallback = true,
			},
		},
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		conform.format({ bufnr = args.buf, async = true, lsp_fallback = true })
	end,
})
