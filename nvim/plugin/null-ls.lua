local null_ls = require("null-ls")

local biome = null_ls.builtins.formatting.biome.with({
	condition = function(utils)
		return utils.root_has_file("biome.json")
	end,
})

local prettier = null_ls.builtins.formatting.prettierd.with({
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"json",
		"yaml",
		"markdown",
		"css",
		"scss",
		"html",
	},
	condition = function(utils)
		return utils.root_has_file(".prettierrc")
			or utils.root_has_file(".prettierrc.json")
			or utils.root_has_file(".prettierrc.js")
	end,
})

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		prettier,
		biome,
	},
	on_attach = function(client)
		if client.server_capabilities.documentFormattingProvider then
			vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.format({ async = true })")
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = false })")
		end
	end,
})
