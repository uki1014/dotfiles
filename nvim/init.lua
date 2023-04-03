local status, impatient = pcall(require, "impatient")
if status then
	impatient.enable_profile()
end

Maps = require("maps")

require("keymap")
require("plugins")
require("config")

vim.cmd([[autocmd BufWritePost plugins.lua PackerCompile]])
