local status, lspconfig = pcall(require, 'lspconfig')
if (not status) then return end

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', Maps.ns)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', Maps.ns)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', Maps.ns)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', Maps.ns)
  buf_set_keymap("n", "gr", '<cmd>lua vim.lsp.buf.references()<CR>', Maps.none)
  buf_set_keymap("n", "<space>D", '<cmd>lua vim.lsp.buf.type_definition()<CR>', Maps.none)
end

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    'html-lsp',
    'css-lsp',
    'deno',
    'dockerls',
    'sumneko_lua',
    'typescript-language-server',
    'solargraph',
    'yamlls',
    'gopls',
    'sqls',
    'eslint_d',
    'prettierd'
  }
})
require("mason-lspconfig").setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {
      on_attach = on_attach
    }
  end,
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

lspconfig.flow.setup {
  on_attach = on_attach,
  settings = { document_formatting = false },
  capabilities = capabilities
}

lspconfig.dockerls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
  settings = { document_formatting = false },
  capabilities = capabilities
}

lspconfig.solargraph.setup{
  cmd = { 'bundle', 'exec', 'solargraph', 'stdio' },
  filetypes = {"ruby", "rakefile", "rspec"},
  settings = { document_formatting = false },
  capabilities = capabilities
}

lspconfig.yamlls.setup{
  capabilities = capabilities
}

lspconfig.gopls.setup{
  capabilities = capabilities
}

lspconfig.denols.setup{
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
}

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },

      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
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
  virtual_text = false,
  update_in_insert = true,
  float = {
    source = 'always', -- Or "if_many"
  },
})
