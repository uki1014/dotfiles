local conform = require("conform")

local function biome_lsp_or_prettier()
	local has_biome = vim.fs.find("biome.json", { upward = true })[1]
	if has_biome then
		return { "biome", "lsp" }
	end

	local has_prettier = vim.fs.find({
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
		return { "prettierd", "lsp" }
	end

	-- どちらもなければ fallback
	return { "lsp" }
end

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
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		conform.format({ bufnr = args.buf, async = true, lsp_fallback = true })
	end,
})
