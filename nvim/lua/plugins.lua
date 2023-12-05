local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"neovim/nvim-lspconfig",
	{
		"williamboman/mason.nvim",
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
			"MasonUpdate",
		},
	},
	"williamboman/mason-lspconfig.nvim",
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		-- version = "<CurrentMajor>.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		version = "v2.1.0",
	},
	"saadparwaiz1/cmp_luasnip",
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		requires = {
			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
	},
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-vsnip",
	"hrsh7th/cmp-buffer",
	"hrsh7th/vim-vsnip",
	{
		"hrsh7th/nvim-insx",
		config = function()
			require("insx.preset.standard").setup()
		end,
	},
	{
		"uki1014/vim-to-github",
		config = function()
			vim.g.to_github_clipboard = "1"

			Maps.nmap("<Leader>gj", ":ToGithubBlobDevelopBranch<CR>", Maps.n)
			Maps.nmap("<Leader>gb", ":ToGithubBlameDevelopBranch<CR>", Maps.n)
			Maps.nmap("<Leader>G", ":ToGithubBlobCommitHash<CR>", Maps.n)
			Maps.nmap("<Leader>GB", ":ToGithubBlameCommitHash<CR>", Maps.n)
			Maps.nmap("<Leader>g", ":ToGithubTargetPullRequest<CR>", Maps.n)
			Maps.nmap("<Leader>j", ":ToGithubTargetPullRequestFromCommitHash<CR>", Maps.n)
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		requires = "nvim-lua/plenary.nvim",
	},
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		config = function()
			require("fidget").setup()
		end,
	},
	"nvim-treesitter/nvim-treesitter",
	{ "yioneko/nvim-yati", requires = "nvim-treesitter/nvim-treesitter" },
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = function()
			require("git-conflict").setup({
				highlights = {
					incoming = "DiffText",
					current = "DiffAdd",
				},
			})
		end,
	},
	{
		"tzachar/highlight-undo.nvim",
		config = function()
			require("highlight-undo").setup({
				duration = 1000,
				undo = {
					hlgroup = "HighlightUndo",
					mode = "n",
					lhs = "u",
					map = "undo",
					opts = {},
				},
				redo = {
					hlgroup = "HighlightUndo",
					mode = "n",
					lhs = "<S-u>",
					map = "redo",
					opts = {},
				},
				highlight_for_count = true,
			})
		end,
	},
	{
		"LunarVim/bigfile.nvim",
		config = function()
			require("bigfile").setup({
				features = {
					"indent_blankline",
					"illuminate",
					"lsp",
					"treesitter",
					"matchparen",
					"vimopts",
					-- "syntax",
					-- "filetype",
				},
			})
		end,
	},
	{
		"itchyny/lightline.vim",
		config = function()
			vim.g.lightline = {
				colorscheme = "default",
				active = {
					left = { { "mode", "paste" }, { "readonly", "filename", "modified" } },
					right = {
						{ "lineinfo" },
						{ "percent" },
						{ "charcode", "fileformat", "filetype" },
					},
				},
				inactive = {
					left = { { "readonly", "filename", "modified" } },
				},
				component = {
					filename = "%f",
				},
				component_function = {
					readonly = "MyReadonly",
					modified = "MyModified",
				},
				separator = { left = "", right = "" },
				subseparator = { left = "", right = "" },
			}
		end,
	},
	-- Finder / Filer
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope-file-browser.nvim",
	{
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	},
	-- Git
	{
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local gitsigns = require("gitsigns")
			gitsigns.setup()
			Maps.nmap("<Leader>gl", function()
				gitsigns.blame_line({
					full = true,
				})
			end, Maps.ns)
		end,
	},
	-- Utils
	{
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				signs = false,
				keywords = {
					NOTE = { color = "hint", alt = { "INFO", "MEMO" } },
				},
				highlight = {
					keyword = "bg",
					after = "",
				},
			})
		end,
	},
	{
		"Yggdroot/indentLine",
		config = function()
			vim.g.indentLine_concealLevel = 1
			vim.g.indentLine_fileTypeExclude =
				{ "help", "nerdtree", "calendar", "thumbnail", "tweetvim", "defx", "TelescopePrompt" }
			vim.g.indentLine_color_term = "239"
			vim.g.indentLine_color_gui = "#708090"
			vim.g.indentLine_char_list = { "┊", "┊", "┊", "┊" }
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				toggler = {
					line = ";e",
					block = ";b",
				},
				opleader = {
					line = ";e",
					block = ";b",
				},
			})
		end,
	},
	{
		"uki1014/vim-zenspace",
		config = function()
			vim.g["zenspace#default_mode"] = "on"
		end,
	},
	"kana/vim-smartword",
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	"windwp/nvim-ts-autotag",
	"andymass/vim-matchup",
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	"tpope/vim-repeat",
	{
		"thaerkh/vim-workspace",
		config = function()
			vim.g.workspace_autocreate = "1"
			vim.g.workspace_undodir = os.getenv("HOME") .. "/.config/nvim/undo/"
			vim.g.workspace_autosave = "0"
			vim.g.workspace_session_directory = os.getenv("HOME") .. "/.config/nvim/sessions/"
		end,
	},
	{
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({
				icons = false,
				fold_open = "v",
				fold_closed = ">",
				use_diagnostic_signs = true,
			})
			Maps.nmap("<Leader>x", ":TroubleToggle<CR>", Maps.ns)
		end,
	},
	{
		"ntpeters/vim-better-whitespace",
		config = function()
			vim.g.better_whitespace_guicolor = "darkred"
			vim.g.strip_whitespace_on_save = 0

			Maps.nmap("<Leader>y", ":StripWhitespace<CR>", Maps.n)
		end,
	},
	{
		"numToStr/BufOnly.nvim",
		config = function()
			Maps.nmap("<Leader>ba", ":BufOnly<CR>", Maps.n)
		end,
	},
	{
		"windwp/nvim-spectre",
		config = function()
			local spectre = require("spectre")
			spectre.setup()

			Maps.nmap("<Leader>m", function()
				spectre.open_visual({
					select_word = true,
				})
			end, Maps.ns)
			Maps.nmap("<Leader>w", function()
				spectre.open_visual()
			end, Maps.ns)
		end,
	},
	"mtdl9/vim-log-highlighting",
	{
		"elzr/vim-json",
		ft = { "json" },
		config = function()
			vim.g.vim_json_syntax_conceal = "0"
		end,
	},
	{ "stephpy/vim-yaml", ft = { "yaml" } },
	{ "dag/vim-fish", ft = { "fish" } },
	{ "cespare/vim-toml", ft = { "toml" } },
	{
		"yuezk/vim-js",
		ft = { "javascript", "javascript.jsx", "javascriptreact", "typescript", "typescript.tsx", "typescriptreact" },
	},
	{
		"maxmellon/vim-jsx-pretty",
		ft = { "javascript", "javascript.jsx", "javascriptreact", "typescript", "typescript.tsx", "typescriptreact" },
	},
	{
		"jparise/vim-graphql",
		ft = { "javascript", "javascript.jsx", "javascriptreact", "typescript", "typescript.tsx", "typescriptreact" },
	},
	{
		"styled-components/vim-styled-components",
		ft = { "javascript", "javascript.jsx", "javascriptreact", "typescript", "typescript.tsx", "typescriptreact" },
	},
	{
		"leafgarland/typescript-vim",
		ft = { "typescript", "typescript.tsx", "typescriptreact" },
	},
	{ "neoclide/jsonc.vim", ft = { "jsonc" } },
	{
		"tpope/vim-markdown",
		ft = { "markdown" },
		config = function()
			vim.g.markdown_fenced_languages =
				{ "html", "python", "bash=sh", "json", "javascript", "typescript", "ruby", "lua", "vim" }
			vim.g.markdown_syntax_conceal = 1
		end,
	},
	{ "SidOfc/mkdx", ft = { "markdown" } },
	{ "pantharshit00/vim-prisma", ft = { "prisma" } },
	{
		"ap/vim-css-color",
		ft = {
			"javascript",
			"javascript.jsx",
			"javascriptreact",
			"typescript",
			"typescript.tsx",
			"typescriptreact",
			"html",
			"css",
			"scss",
			"less",
			"vim",
			"lua",
		},
	},
	{
		"mechatroner/rainbow_csv",
		ft = { "csv", "tsv" },
		lazy = true,
	},
	{
		"RRethy/nvim-treesitter-endwise",
		ft = { "ruby", "lua", "vimscript", "bash" },
		lazy = true,
	},
	{
		"hashivim/vim-terraform",
		ft = { "terraform" },
	},
	{
		"wuelnerdotexe/vim-astro",
		ft = { "astro" },
		config = function()
			vim.g.astro_typescript = "enable"
		end,
		lazy = true,
	},
	{
		"previm/previm",
		ft = { "markdown" },
		config = function()
			vim.g.previm_open_cmd = 'open -a "Google Chrome"'
			Maps.nmap("<Leader>a", ":PrevimOpen<CR>", Maps.n)
		end,
		lazy = true,
	},

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						accept = "<Tab>",
					},
				},
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		requires = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
		lazy = true,
	},
})
