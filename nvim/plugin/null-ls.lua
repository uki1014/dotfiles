local null_ls = require("null-ls")

local biome = null_ls.builtins.formatting.biome.with({
	condition = function(utils)
		return utils.root_has_file("biome.json")
	end,
})

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettierd,
		biome,
	},
	on_attach = function(client)
		if client.server_capabilities.documentFormattingProvider then
			vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.format({ async = true })")
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = false })")
		end
	end,
})
