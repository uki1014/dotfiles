vim.loader.enable()

-- 未使用プロバイダを無効化（checkhealth警告抑止）
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0

Maps = require("maps")

require("keymap")
require("config")
require("plugins")
