-- Mason setup for LSP server installation
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "html",
    "cssls",
    "cssmodules_ls",
    "dockerls",
    "lua_ls",
    "ts_ls",
    "gopls",
    "sqls",
    "eslint",
    "graphql",
    "jsonls",
    "marksman",
    "prismals",
    "taplo",
    "vimls",
    "terraformls",
    "biome",
  },
})

-- Global capabilities with semantic tokens disabled
local default_capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
default_capabilities.textDocument.semanticTokens = nil

-- LspAttach: on_attach equivalent using new API
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf

    -- Disable formatting for specific servers
    if client.name == "ts_ls" or client.name == "lua_ls" or client.name == "biome" or client.name == "eslint" then
      client.server_capabilities.documentFormattingProvider = false
    end

    -- Disable semantic tokens
    client.server_capabilities.semanticTokensProvider = nil

    -- ESLint auto-fix on save
    if client.name == "eslint" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          local params = {
            command = "eslint.applyAllFixes",
            arguments = {
              {
                uri = vim.uri_from_bufnr(bufnr),
                version = vim.lsp.util.buf_versions[bufnr],
              },
            },
          }
          client.request_sync("workspace/executeCommand", params, 1000, bufnr)
        end,
      })
    end

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Keymaps
    local function buf_set_keymap(mode, lhs, rhs, opts)
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", Maps.ns)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", Maps.ns)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", Maps.ns)
    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", Maps.ns)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", Maps.none)
    buf_set_keymap("n", "L", "<cmd>lua vim.diagnostic.goto_next()<CR>", Maps.none)
    buf_set_keymap("n", "H", "<cmd>lua vim.diagnostic.goto_prev()<CR>", Maps.none)
    buf_set_keymap("n", "<space>d", "<cmd>lua vim.lsp.buf.type_definition()<CR>", Maps.none)
  end,
})

-- LSP Server Configurations using vim.lsp.config
vim.lsp.config.dockerls = {
  cmd = { "docker-langserver", "--stdio" },
  filetypes = { "dockerfile", "Dockerfile" },
  root_markers = { "Dockerfile" },
  capabilities = default_capabilities,
}

vim.lsp.config.ts_ls = {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  root_markers = { "package.json", "tsconfig.json" },
  capabilities = default_capabilities,
}

vim.lsp.config.astro = {
  cmd = { "astro-ls", "--stdio" },
  filetypes = { "astro" },
  root_markers = { "package.json", "tsconfig.json" },
  capabilities = default_capabilities,
}

vim.lsp.config.terraformls = {
  cmd = { "terraform-ls", "serve" },
  filetypes = { "terraform" },
  root_markers = { ".git" },
  capabilities = default_capabilities,
}

vim.lsp.config.biome = {
  cmd = { "biome", "lsp-proxy" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "jsonc",
    "css",
  },
  root_markers = { "biome.json" },
  capabilities = default_capabilities,
}

vim.lsp.config.eslint = {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = { ".eslintrc.cjs", ".eslintrc.js", ".eslintrc.json", ".eslintrc" },
  capabilities = default_capabilities,
}

vim.lsp.config.gopls = {
  cmd = { "gopls" },
  filetypes = { "go" },
  root_markers = { "go.mod", ".git" },
  capabilities = default_capabilities,
}

vim.lsp.config.lua_ls = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", ".git" },
  capabilities = default_capabilities,
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
}

-- Enable all configured servers
vim.lsp.enable({
  "dockerls",
  "ts_ls",
  "astro",
  "terraformls",
  "biome",
  "eslint",
  "gopls",
  "lua_ls",
})

-- Diagnostic handlers and configuration
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
    source = "always",
  },
})
