local status, lspconfig = pcall(require, "lspconfig")
if not status then
	return
end

local on_attach = function(client, bufnr)
	if
		client.name == "tsserver"
		or client.name == "solargraph"
		or client.name == "flow"
		or client.name == "sumneko_lua"
	then
		client.resolved_capabilities.document_formatting = false
	end

	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", Maps.ns)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", Maps.ns)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", Maps.ns)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", Maps.ns)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", Maps.none)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", Maps.none)
end

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"html-lsp",
		"css-lsp",
		"dockerls",
		"sumneko_lua",
		"stylua",
		"typescript-language-server",
		"solargraph",
		"yamlls",
		"gopls",
		"sqls",
		"eslint-lsp",
		"prettierd",
	},
})

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.flow.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.dockerls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.tsserver.setup({
	on_attach = on_attach,
	filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
	root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json"),
	capabilities = capabilities,
})

lspconfig.solargraph.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "ruby", "rakefile", "rspec" },
	cmd = { "bundle", "exec", "solargraph", "stdio" },
	document_formatting = false,
})

lspconfig.eslint.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	root_dir = lspconfig.util.root_pattern("eslintrc.js", "babel.config.js"),
})

lspconfig.yamlls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	update_in_insert = false,
	virtual_text = false,
	severity_sort = true,
})

vim.cmd("au CursorHold * silent lua vim.lsp.diagnostic.show_line_diagnostics()")

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = "✘", Warn = "▲", Hint = "●", Info = ">" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
	virtual_text = false,
	update_in_insert = true,
	float = {
		source = "always", -- Or 'if_many'
	},
})
