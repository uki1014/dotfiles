local conform = require("conform")

local function biome_lsp_or_prettier(bufnr)
	local has_biome_lsp = vim.lsp.get_clients({
		bufnr = bufnr,
		name = "biome",
	})[1]
	if has_biome_lsp then
		return {}
	end
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
		return { "prettierd", stop_after_first = true }
	end
	return { "biome", stop_after_first = true }
end

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		json = biome_lsp_or_prettier,
		javascript = biome_lsp_or_prettier,
		javascriptreact = biome_lsp_or_prettier,
		typescript = biome_lsp_or_prettier,
		typescriptreact = biome_lsp_or_prettier,
		astro = biome_lsp_or_prettier,
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		conform.format({ bufnr = args.buf })
	end,
})
