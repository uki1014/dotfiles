local conform = require("conform")
local js_formatters =
	{ "biome", "prettierd", "prettier", "yaml", "markdown", "css", "scss", "html", stop_after_first = true }

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		json = js_formatters,
		javascript = js_formatters,
		javascriptreact = js_formatters,
		typescript = js_formatters,
		typescriptreact = js_formatters,
		astro = js_formatters,
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		conform.format({ bufnr = args.buf })
	end,
})
