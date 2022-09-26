local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.fish,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.diagnostics.rubocop.with({
			command = "bundle",
			args = { "exec", "rubocop", "-f", "json", "--stdin", "$FILENAME" },
		}),
		-- null_ls.builtins.formatting.rubocop.with({
		--   command = "bundle",
		--   args = { "exec", "rubocop", "--auto-correct", "-f", "quiet", "--stderr", "--stdin", "$FILENAME" },
		-- }),
	},
	on_attach = function(client)
		if client.server_capabilities.documentFormattingProvider then
			vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()")
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		end
	end,
})
