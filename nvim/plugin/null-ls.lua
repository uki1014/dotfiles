local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.fish,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.diagnostics.rubocop.with {
      command = 'bundle',
      args = { 'exec', 'rubocop', '-f', 'json', '--stdin', '$FILENAME' },
    },
    null_ls.builtins.formatting.rubocop.with {
      command = 'bundle',
      args = { 'exec', 'rubocop', '--auto-correct', '-f', 'quiet', '--stderr', '--stdin', '$FILENAME' },
    },
  },
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()")
    end
  end
})
