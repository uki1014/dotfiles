Maps = require("maps")

require("impatient").enable_profile()
require("keymap")
require("plugins")
require("config")

vim.cmd([[autocmd BufWritePost plugins.lua PackerCompile]])
