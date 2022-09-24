local packer_bootstrap = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  vim.cmd [[packadd packer.nvim]]
  return false
end

local packer = require('packer')

return packer.startup(function(use)
  use {
    'wbthomason/packer.nvim',
    config = function()
      Maps.nmap('<Leader>uf', ':PackerCompile<CR>', Maps.n)
      Maps.nmap('<Leader>ud', ':PackerSync<CR>', Maps.n)
      Maps.nmap('<Leader>uy', ':PackerInstall<CR>', Maps.n)
      Maps.nmap('<Leader>uc', ':PackerClean<CR>', Maps.n)
      Maps.nmap('<Leader>us', ':PackerStatus<CR>', Maps.n)
    end
  }
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/vim-vsnip'
  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = 'nvim-lua/plenary.nvim'
  }
  use {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup()
    end
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
  }
  use 'uki1014/vim-to-github'
  use 'itchyny/lightline.vim'
  -- Finder / Filer
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
  }
  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
  }
  -- Utils
  use {
    'alvan/vim-closetag',
    config = function()
      vim.g.closetag_filenames = '*.html,*.xhtml,*xml,*.phtml,*.erb,*.php,*.vue,*.js,*.jsx,*.ts,*.tsx'
    end
  }
  use 'Yggdroot/indentLine'
  use 'preservim/nerdcommenter'
  use {
    'uki1014/vim-zenspace',
    config = function()
      vim.g['zenspace#default_mode'] = 'on'
    end
  }
  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use {
    'previm/previm',
    config = function()
      vim.g.previm_open_cmd = 'open -a "Google Chrome"'

      Maps.nmap('<Leader>a', ':PrevimOpen<CR>', Maps.n)
    end
  }
  use {
    'thaerkh/vim-workspace',
    config = function()
      vim.g.workspace_autocreate = '1'
      vim.g.workspace_undodir = os.getenv('HOME')..'/.config/nvim/sessions/'
      vim.g.workspace_autosave = '0'
      vim.g.workspace_session_directory = os.getenv('HOME')..'/.config/nvim/sessions/'
    end
  }
  use {
    'ntpeters/vim-better-whitespace',
    config = function()
      vim.g.better_whitespace_guicolor = 'darkred'
      vim.g.strip_whitespace_on_save = 0

      Maps.nmap('<Leader>y', ':StripWhitespace<CR>', Maps.n)
    end
  }
  use {
    'numToStr/BufOnly.nvim',
    config = function()
      Maps.nmap('<Leader>ba', ':BufOnly<CR>', Maps.n)
    end
  }
  use 'windwp/nvim-spectre'
  use 'mtdl9/vim-log-highlighting'
  use {
    'elzr/vim-json',
    ft = { 'json' },
    config = function()
      vim.g.vim_json_syntax_conceal = '0'
    end
  }
  use { 'stephpy/vim-yaml', ft = { 'yaml' } }
  use { 'kchmck/vim-coffee-script', ft = { 'coffee' } }
  use { 'dag/vim-fish', ft = { 'fish' } }
  use { 'cespare/vim-toml', ft = { 'toml' } }
  use {
    'yuezk/vim-js',
    ft = { 'javascript', 'javascript.jsx', 'javascriptreact', 'typescript', 'typescript.tsx', 'typescriptreact' },
  }
  use {
    'maxmellon/vim-jsx-pretty',
    ft = { 'javascript', 'javascript.jsx', 'javascriptreact', 'typescript', 'typescript.tsx', 'typescriptreact' },
  }
  use {
    'jparise/vim-graphql',
    ft = { 'javascript', 'javascript.jsx', 'javascriptreact', 'typescript', 'typescript.tsx', 'typescriptreact' },
  }
  use {
    'styled-components/vim-styled-components',
    ft = { 'javascript', 'javascript.jsx', 'javascriptreact', 'typescript', 'typescript.tsx', 'typescriptreact' },
  }
  use {
    'leafgarland/typescript-vim',
    ft = { 'typescript', 'typescript.tsx', 'typescriptreact' },
  }
  use { 'neoclide/jsonc.vim', ft = { 'jsonc' } }
  use {
    'fatih/vim-go',
    ft = { 'go' },
    config = function()
      vim.g.go_disable_autoinstall = '1'
      Maps.nmap('<Leader>gr', ':GoRun<CR>', Maps.n)
    end
  }
  use {
    'tpope/vim-rails',
    ft = { 'ruby' },
    config = function()
      Maps.nmap('<Leader>1', ':A<CR>', Maps.n)
    end
  }
  use { 'joker1007/vim-ruby-heredoc-syntax', ft = { 'ruby' } }
  use { 'joker1007/vim-markdown-quote-syntax', ft = { 'markdown' } }
  use { 'tbastos/vim-lua', ft = { 'lua' } }
  use { 'L3MON4D3/LuaSnip', tag = 'v<CurrentMajor>.*', ft = { 'lua' } }
  use { 'pantharshit00/vim-prisma', ft = { 'prisma' } }
  use {
    'ap/vim-css-color',
    ft = {
      'javascript',
      'javascript.jsx',
      'javascriptreact',
      'typescript',
      'typescript.tsx',
      'typescriptreact',
      'html',
      'css',
      'scss',
      'less',
      'vim',
      'lua',
    },
  }
  use {
    'mechatroner/rainbow_csv',
    ft = { 'csv', 'tsv' },
  }

  if packer_bootstrap() then
    require('packer').sync()
  end
end)
