local status, lspconfig = pcall(require, "lspconfig")
if not status then
	return
end

local on_attach = function(client, bufnr)
	if client.name == "tsserver" or client.name == "lua_ls" then
		client.server_capabilities.documentFormattingProvider = false
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
	buf_set_keymap("n", "L", "<cmd>lua vim.diagnostic.goto_next()<CR>", Maps.none)
	buf_set_keymap("n", "H", "<cmd>lua vim.diagnostic.goto_prev()<CR>", Maps.none)
	buf_set_keymap("n", "<space>d", "<cmd>lua vim.lsp.buf.type_definition()<CR>", Maps.none)

	client.server_capabilities.semanticTokensProvider = nil
end

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"html",
		"cssls",
		"cssmodules_ls",
		"dockerls",
		"lua_ls",
		"tsserver",
		-- "yamlls",
		"gopls",
		"sqls",
		"eslint",
		-- "clangd",
		"graphql",
		"jsonls",
		"marksman",
		"prismals",
		"taplo", -- toml
		"vimls",
		"terraformls",
		-- "stylua", -- TODO: コメントアウトはずしたらauto installが走らないけど必要なので手動で入れる
		-- "prettierd", -- TODO: コメントアウトはずしたらauto installが走らないけど必要なので手動で入れる
	},
})
require("mason-lspconfig").setup_handlers({
	function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		lspconfig.dockerls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "dockerfile", "Dockerfile" },
		})

		lspconfig.tsserver.setup({
			on_attach = on_attach,
			filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
			root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json"),
			capabilities = capabilities,
		})

		lspconfig.astro.setup({
			on_attach = on_attach,
			filetypes = { "astro" },
			root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json"),
			capabilities = capabilities,
		})

		lspconfig.terraformls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = {
				"terraform",
			},
			root_dir = lspconfig.util.root_pattern(".git"),
		})

		lspconfig.eslint.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
			},
			root_dir = lspconfig.util.root_pattern("package.json"),
		})

		lspconfig.gopls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "go" },
		})

		lspconfig.lua_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "lua" },
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim", "Maps" },
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})
	end,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	update_in_insert = false,
	virtual_text = false,
	severity_sort = true,
})

vim.cmd("au CursorHold * silent lua vim.diagnostic.open_float()")

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
