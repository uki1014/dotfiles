local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		-- null_ls.builtins.diagnostics.fish,
		-- null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.biome,
	},
	on_attach = function(client)
		if client.server_capabilities.documentFormattingProvider then
			vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.format({ async = true })")
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = false })")
		end
	end,
})
