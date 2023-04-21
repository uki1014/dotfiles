-- https://dotfyle.com/

local packer_bootstrap = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	vim.cmd([[packadd packer.nvim]])
	return false
end

local packer = require("packer")

return packer.startup(function(use)
	use({
		"wbthomason/packer.nvim",
		config = function()
			Maps.nmap("<Leader>uf", ":PackerCompile<CR>", Maps.n)
			Maps.nmap("<Leader>ud", ":PackerSync<CR>", Maps.n)
			Maps.nmap("<Leader>uy", ":PackerInstall<CR>", Maps.n)
			Maps.nmap("<Leader>uc", ":PackerClean<CR>", Maps.n)
			Maps.nmap("<Leader>us", ":PackerStatus<CR>", Maps.n)
		end,
	})
	use("neovim/nvim-lspconfig")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
	})
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/vim-vsnip")
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = "nvim-lua/plenary.nvim",
	})
	use("lewis6991/impatient.nvim")
	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})
	use({ "yioneko/nvim-yati", requires = "nvim-treesitter/nvim-treesitter" })
	use("uki1014/vim-to-github")
	use({
		"akinsho/git-conflict.nvim",
		tag = "*",
		config = function()
			require("git-conflict").setup({
				highlights = {
					incoming = "DiffText",
					current = "DiffAdd",
				},
			})
		end,
	})
	use("itchyny/lightline.vim")
	-- Finder / Filer
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope-file-browser.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
	-- Git
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
	-- Utils
	use({
		"alvan/vim-closetag",
		config = function()
			vim.g.closetag_filenames = "*.html,*.xhtml,*xml,*.phtml,*.erb,*.php,*.vue,*.js,*.jsx,*.ts,*.tsx"
		end,
	})
	use({
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
	})
	use("Yggdroot/indentLine")
	use("preservim/nerdcommenter")
	use({
		"uki1014/vim-zenspace",
		config = function()
			vim.g["zenspace#default_mode"] = "on"
		end,
	})
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	use("andymass/vim-matchup")
	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use({
		"thaerkh/vim-workspace",
		config = function()
			vim.g.workspace_autocreate = "1"
			vim.g.workspace_undodir = os.getenv("HOME") .. "/.config/nvim/undo/"
			vim.g.workspace_autosave = "0"
			vim.g.workspace_session_directory = os.getenv("HOME") .. "/.config/nvim/sessions/"
		end,
	})
	use({
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
	})
	use({
		"ntpeters/vim-better-whitespace",
		config = function()
			vim.g.better_whitespace_guicolor = "darkred"
			vim.g.strip_whitespace_on_save = 0

			Maps.nmap("<Leader>y", ":StripWhitespace<CR>", Maps.n)
		end,
	})
	use({
		"numToStr/BufOnly.nvim",
		config = function()
			Maps.nmap("<Leader>ba", ":BufOnly<CR>", Maps.n)
		end,
	})
	use("windwp/nvim-spectre")
	use("mtdl9/vim-log-highlighting")
	use({
		"elzr/vim-json",
		ft = { "json" },
		config = function()
			vim.g.vim_json_syntax_conceal = "0"
		end,
	})
	use({ "stephpy/vim-yaml", ft = { "yaml" } })
	use({ "dag/vim-fish", ft = { "fish" } })
	use({ "cespare/vim-toml", ft = { "toml" } })
	use({
		"yuezk/vim-js",
		ft = { "javascript", "javascript.jsx", "javascriptreact", "typescript", "typescript.tsx", "typescriptreact" },
	})
	use({
		"maxmellon/vim-jsx-pretty",
		ft = { "javascript", "javascript.jsx", "javascriptreact", "typescript", "typescript.tsx", "typescriptreact" },
	})
	use({
		"jparise/vim-graphql",
		ft = { "javascript", "javascript.jsx", "javascriptreact", "typescript", "typescript.tsx", "typescriptreact" },
	})
	use({
		"styled-components/vim-styled-components",
		ft = { "javascript", "javascript.jsx", "javascriptreact", "typescript", "typescript.tsx", "typescriptreact" },
	})
	use({
		"leafgarland/typescript-vim",
		ft = { "typescript", "typescript.tsx", "typescriptreact" },
	})
	use({ "neoclide/jsonc.vim", ft = { "jsonc" } })
	use({
		"tpope/vim-markdown",
		ft = { "markdown" },
		config = function()
			vim.g.markdown_fenced_languages =
				{ "html", "python", "bash=sh", "json", "javascript", "typescript", "ruby", "lua", "vim" }
			vim.g.markdown_syntax_conceal = 1
		end,
	})
	use({ "SidOfc/mkdx", ft = { "markdown" } })
	use({ "tbastos/vim-lua", ft = { "lua" } })
	use({ "pantharshit00/vim-prisma", ft = { "prisma" } })
	use({
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
	})
	use({
		"mechatroner/rainbow_csv",
		ft = { "csv", "tsv" },
	})
	use({
		"RRethy/nvim-treesitter-endwise",
		ft = { "ruby", "lua", "vimscript", "bash" },
	})
	use({
		"hashivim/vim-terraform",
		ft = { "terraform" },
	})
	use({
		"wuelnerdotexe/vim-astro",
		ft = { "astro" },
		config = function()
			vim.g.astro_typescript = "enable"
		end,
	})
	use({
		"previm/previm",
		ft = { "markdown" },
		config = function()
			vim.g.previm_open_cmd = 'open -a "Google Chrome"'

			Maps.nmap("<Leader>a", ":PrevimOpen<CR>", Maps.n)
		end,
	})
	-- use({ "github/copilot.vim" })

	use({
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
	})
	use({
		"zbirenbaum/copilot-cmp",
		requires = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	})

	if packer_bootstrap() then
		require("packer").sync()
	end
end)
