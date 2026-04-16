local ok, nts = pcall(require, "nvim-treesitter")
if not ok then
	return
end

nts.install({
	"toml",
	"fish",
	"json",
	"yaml",
	"css",
	"html",
	"lua",
	"javascript",
	"typescript",
	"tsx",
	"proto",
	"python",
	"scss",
	"prisma",
	"markdown",
	"astro",
	"graphql",
	"svelte",
	"vim",
})

vim.treesitter.language.register("tsx", {
	"javascript",
	"javascript.jsx",
	"javascriptreact",
	"typescript",
	"typescript.tsx",
	"typescriptreact",
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("NvimTreesitterIndent", { clear = true }),
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
		if lang and vim.treesitter.language.add(lang) then
			vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})
