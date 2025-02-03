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
		version = "v1.1.0",
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
		"stevearc/conform.nvim",
		opts = {},
	},
	{
		"j-hui/fidget.nvim",
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
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = false,
					theme = "solarized_dark",
				},
				tabline = {
					lualine_a = { "filename" },
					lualine_b = { "tabs" },
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				inactive_winbar = {
					lualine_a = {},
					lualine_b = { "filename" },
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff" },
					lualine_c = {
						{
							"filename",
							path = 1,
							shorting_target = 0,
						},
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
			})
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
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("ibl").setup({
				indent = { char = "┊" },
				whitespace = {
					remove_blankline_trail = true,
				},
				scope = {
					show_start = false,
					show_end = false,
					highlight = { "Function", "Label" },
					include = {
						node_type = { ["*"] = { "*" } },
					},
				},
			})
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
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	"JoosepAlviste/nvim-ts-context-commentstring",
	{
		"uki1014/vim-zenspace",
		config = function()
			vim.g["zenspace#default_mode"] = "on"
		end,
	},
	"kana/vim-smartword",
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
			})
		end,
	},
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
		"MagicDuck/grug-far.nvim",
		config = function()
			local grugFar = require("grug-far")
			grugFar.setup({
				icons = "",
			})
			Maps.nmap("<localleader>m", function()
				grugFar.open({ prefills = { search = vim.fn.expand("<cword>") } })
			end, Maps.ns)
			Maps.nmap("<localleader>w", function()
				grugFar.open()
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
		ft = {
			"graphql",
			"javascript",
			"javascript.jsx",
			"javascriptreact",
			"typescript",
			"typescript.tsx",
			"typescriptreact",
		},
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
		"google/vim-jsonnet",
		ft = { "jsonnet" },
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
	"github/copilot.vim",
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			-- See Configuration section for options
		},
		config = function()
			local select = require("CopilotChat.select")
			require("CopilotChat").setup({
				debug = true,
				show_help = "yes",
				prompts = {
					Explain = {
						prompt = "/COPILOT_EXPLAIN アクティブな選択範囲の説明を段落形式で書いてください。日本語で返答ください。",
					},
					Review = {
						prompt = "/COPILOT_REVIEW 選択されたコードをレビューしてください。日本語で返答ください。",
					},
					FixCode = {
						prompt = "/COPILOT_GENERATE このコードには問題があります。バグを修正したコードに書き直してください。日本語で返答ください。",
					},
					Refactor = {
						prompt = "/COPILOT_GENERATE 明瞭性と可読性を向上させるために、次のコードをリファクタリングしてください。日本語で返答ください。",
					},
					BetterNamings = {
						prompt = "/COPILOT_GENERATE 選択されたコードの変数名や関数名を改善してください。日本語で返答ください。",
					},
					Documentation = {
						prompt = "/COPILOT_GENERATE 選択範囲にドキュメントコメントを追加してください。日本語で返答ください。",
					},
					Tests = {
						prompt = "/COPILOT_GENERATE コードのテストを生成してください。日本語で返答ください。",
					},
					Wording = {
						prompt = "/COPILOT_GENERATE 次のテキストの文法と表現を改善してください。日本語で返答ください。",
					},
					Summarize = {
						prompt = "/COPILOT_GENERATE 選択範囲の要約を書いてください。日本語で返答ください。",
					},
					Spelling = {
						prompt = "/COPILOT_GENERATE 次のテキストのスペルミスを修正してください。日本語で返答ください。",
					},
					FixDiagnostic = {
						prompt = "ファイル内の次の問題を支援してください:",
						selection = select.diagnostics,
					},
					Commit = {
						prompt = "変更のコミットメッセージをcommitizenの規約に従って日本語で書いてください。タイトルは最大50文字、メッセージは72文字で折り返してください。メッセージ全体をgitcommit言語のコードブロックで囲んでください。",
						selection = select.gitdiff,
					},
					CommitStaged = {
						prompt = "変更のコミットメッセージをcommitizenの規約に従って日本語で書いてください。タイトルは最大50文字、メッセージは72文字で折り返してください。メッセージ全体をgitcommit言語のコードブロックで囲んでください。",
						selection = function(source)
							return select.gitdiff(source, true)
						end,
					},
				},
			})

			function CopilotChatBuffer()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
				end
			end

			Maps.nmap("<Leader>gh", ":lua CopilotChatBuffer()<CR>", Maps.n)
		end,
	},
	{
		"sindrets/diffview.nvim",
		config = function()
			require("diffview").setup({
				use_icons = false,
			})
			Maps.nmap("<Leader>ag", ":DiffviewOpen<CR>", Maps.n)
			Maps.nmap("<Leader>aa", ":DiffviewFileHistory<CR>", Maps.n)
		end,
	},
	{
		"craftzdog/solarized-osaka.nvim",
		config = function()
			require("solarized-osaka").setup({
				day_brightness = 1, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
				dim_inactive = true, -- dims inactive windows
				on_highlights = function(hl, _)
					hl.NormalNC = { bg = "none" }
					hl.Visual = { bg = "#3c3836" }
				end,
			})
			vim.cmd([[colorscheme solarized-osaka]])
		end,
	},
})
