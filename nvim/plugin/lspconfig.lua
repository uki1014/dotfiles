local status, nvim_lsp = pcall(require, 'lspconfig')
if (not status) then return end

local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
  -- LSPサーバーのフォーマット機能を無効にするには下の行をコメントアウト
  -- 例えばtypescript-language-serverにはコードのフォーマット機能が付いているが代わりにprettierでフォーマットしたいときなどに使う
  client.resolved_capabilities.document_formatting = false

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  buf_set_keymap('n', 'gD', function() vim.lsp.buf.declaration() end, Maps.ns)
  buf_set_keymap('n', 'gd', function() vim.lsp.buf.definition() end, Maps.ns)
  buf_set_keymap('n', 'gi', function() vim.lsp.buf.implementation() end, Maps.ns)
  buf_set_keymap('n', 'K', function() vim.lsp.buf.hover() end, Maps.ns)
  buf_set_keymap("n", "gr", function() vim.lsp.buf.references() end, Maps.none)
  buf_set_keymap("n", "<space>D", function() vim.lsp.buf.type_definition() end, Maps.none)
end

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {
      on_attach = on_attach
    }
  end,
}

-- "default": "\uf29c"
protocol.CompletionItemKind = {
  'ue612', -- Text
  'uf09a', -- Method
  'u0192', -- Function
  'uf475', -- Constructor
  'ue624', -- Field
  'ue79b', -- Variable
  'uf0e8', -- Class
  'uf417', -- Interface
  'uf40d', -- Module
  'ue624', -- Property
  'uf475', -- Unit
  'uf89f', -- Value
  'uf435', -- Enum
  'uf1de', -- Keyword
  'ue60b﬌', -- Snippet
  'ue22b', -- Color
  'uf723', -- File
  'ufa46', -- Reference
  'uf114', -- Folder
  'uf02b', -- EnumMember
  'uf8fe', -- Constant
  'ufb44', -- Struct
  'ufacd', -- Event
  'u03a8', -- Operator
  'uf728', -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

nvim_lsp.flow.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities
}

nvim_lsp.sourcekit.setup {
  on_attach = on_attach,
}

nvim_lsp.sumneko_lua.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },

      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
    },
  },
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = false,
  severity_sort = true,
})

vim.cmd('au CursorHold * silent lua vim.lsp.diagnostic.show_line_diagnostics()')

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = "✘ ", Warn = "▲ ", Hint = "●", Info = "> " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '●'
  },
  update_in_insert = true,
  float = {
    source = 'always', -- Or "if_many"
  },
})
