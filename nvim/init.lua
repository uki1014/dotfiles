Maps = require("maps")

require("keymap")
require("plugins")
require("config")

vim.cmd([[autocmd BufWritePost plugins.lua PackerCompile]])
