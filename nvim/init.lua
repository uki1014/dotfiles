require('keymap')
require('plugins')
require('config')

Maps = require('maps')

vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]
