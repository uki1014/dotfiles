Maps = require("maps")

require("keymap")
require("plugins")
require("impatient").enable_profile()
require("config")

vim.cmd([[autocmd BufWritePost plugins.lua PackerCompile]])
