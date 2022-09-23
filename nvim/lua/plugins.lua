maps = require('maps')

packer_bootstrap = function()
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
      maps.nmap('<Leader>uf', ':PackerCompile<CR>', maps.n)
      maps.nmap('<Leader>ud', ':PackerSync<CR>', maps.n)
    end
  }

  use {
    'neoclide/coc.nvim',
    tag = 'v0.0.81',
    config = function()
      maps.nmap('<Leader>co', ':call coc#util#install()<CR>', maps.n)
      maps.nmap('<Leader>col', ':CocOpenLog<CR>', maps.n)
      maps.nmap('<Leader>cre', ':call coc#refresh()<CR>', maps.n)

      maps.nmap('gd', '<Plug>(coc-definition)', maps.s)
      maps.nmap('gy', '<Plug>(coc-type-definition)', maps.s)
      maps.nmap('gi', '<Plug>(coc-implementation)', maps.s)
      maps.nmap('gr', '<Plug>(coc-references)', maps.s)
      maps.nmap('K', ':lua show_documentation()<CR>', maps.ns)


      maps.imap('<CR>', 'pumvisible() ? "<C-y>" : "<C-g>u<CR>"', maps.ne)

      vim.cmd('let coc_path = globpath(&rtp, "autoload/coc.vim")')
      if not vim.fn.empty(coc_path) then
        function coc_configure_and_start()
          vim.g.coc_user_config = {}
          vim.g.coc_user_config['coc.preferences.jumpCommand'] = ':SplitIfNotOpen4COC'
        end
      end

      function check_back_space()
        local col = vim.fn.col('.') - 1
        if col == 0 or fn.getline("."):sub(col, col):match("%s") then
          return true
        else
          return false
        end
      end

      function show_documentation()
        if vim.fn.index({"vim","help"}, filetype) >= 0 then
          vim.cmd('h'.. vim.fn.expand('<cword>'))
        else
          vim.fn.CocAction('doHover')
        end
      end

      vim.cmd('au CursorHold * silent call CocActionAsync("highlight")')

      vim.cmd('augroup mygroup')
      vim.cmd('au!')
      vim.cmd('au FileType typescript,json setl formatexpr=CocAction("formatSelected")')
      vim.cmd('au User CocJumpPlaceholder call CocActionAsync("showSignatureHelp")')
      vim.cmd('augroup END')

      vim.cmd('au FileType scss setl iskeyword+=@-@')

      vim.cmd("au BufNewFile,BufReadPre,BufEnter *.{flow,config.js,config.copy.js,config.lib.js,config.style.js,config.proxy.js} call coc#config('eslint.enable', v:false)")
      vim.cmd("au BufLeave *.{js,jsx,ts,tsx} call coc#config('eslint.enable', v:true)")

      vim.g.coc_global_extensions = {
        'coc-tsserver',
        'coc-flow',
        'coc-prettier',
        'coc-eslint',
        'coc-solargraph',
        'coc-css',
        'coc-sh',
        'coc-tabnine',
        'coc-cssmodules',
        'coc-styled-components',
        'coc-vimlsp',
        'coc-prisma'
      }


      vim.cmd('command! -nargs=0 Prettier :CocCommand prettier.formatFile')
    end
  }

  use {
    'uki1014/vim-to-github',
    config = function()
      vim.g.to_github_clipboard = '1'

      maps.nmap('<Leader>gj', ':ToGithubBlobDevelopBranch<CR>', maps.n)
      maps.nmap('<Leader>gb', ':ToGithubBlameDevelopBranch<CR>', maps.n)
      maps.nmap('<Leader>G', ':ToGithubBlobCommitHash<CR>', maps.n)
      maps.nmap('<Leader>GB', ':ToGithubBlameCommitHash<CR>', maps.n)
      maps.nmap('<Leader>g', ':ToGithubTargetPullRequest<CR>', maps.n)
      maps.nmap('<Leader>j', ':ToGithubTargetPullRequestFromCommitHash<CR>', maps.n)
    end
  }

  use {
    'itchyny/lightline.vim',
    config = function()
      vim.g.lightline = {
        colorscheme = 'default',
        active = {
          left = { { 'mode', 'paste' },
                   { 'readonly', 'filename', 'modified' }
                  },
          right = {
            { 'lineinfo' },
            { 'percent' },
            { 'charcode', 'fileformat', 'filetype' },
          }
        },
        inactive = {
          left = { { 'readonly', 'filename', 'modified' } }
        },
        component = {
          filename = '%f'
        },
        component_function = {
          readonly = 'MyReadonly',
          modified = 'MyModified',
        },
        separator = { left = '', right = '' },
        subseparator = { left = '', right = '' }
      }
    end
  }

  -- Finder / Filer
  use {
    'nvim-lua/plenary.nvim'
  }

  use 'nvim-telescope/telescope-file-browser.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      local telescope = require('telescope')
      telescope.load_extension("file_browser")
      local telescope_actions = require('telescope.actions')
      local file_browser_actions = telescope.extensions.file_browser.actions

      local function telescope_buffer_dir()
        return vim.fn.expand('%:p:h')
      end

      local function open_file_browser(initial_mode)
        telescope.extensions.file_browser.file_browser({
          dir_icon = "",
          path = "%:p:h",
          cwd = telescope_buffer_dir(),
          respect_gitignore = false,
          hidden = false,
          grouped = true,
          all_previewer = true,
          initial_mode = initial_mode,
          select_buffer = true,
          dir_icon = '▸',
          -- layout_config = { width = 200, height = 50 },
        })
      end

      maps.nmap(';f', ':Telescope find_files find_command=rg,--ignore-case,--hidden,--files<CR>', maps.ns)
      maps.nmap(';r', ':Telescope live_grep find_command=rg,--ignore-case,--hidden,--files<CR>', maps.ns)
      maps.nmap(';;', ':Telescope grep_string find_command=rg,--ignore-case,--hidden,--files<CR>', maps.ns)
      maps.nmap(';t', ':lua require("telescope.builtin").resume()<CR>', maps.ns)
      maps.nmap(';c', ':lua require("telescope.builtin").command_history{}<CR>', maps.ns)
      maps.nmap(';e', ':Telescope buffers<CR>', maps.ns)

      -- only ruby
      maps.nmap(';h', ':Telescope find_files find_command=rg,--ignore-case,--hidden,--files,--type=ruby<CR>', maps.ns)
      maps.nmap(';hr', ':lua require("telescope.builtin").live_grep({ additional_args = function() return { "--type=ruby" } end })<CR>', maps.ns)

      -- ignore spec directory
      maps.nmap(';w', ':Telescope find_files find_command=rg,--ignore-case,--hidden,--files,--type=ruby,--glob=!spec<CR>', maps.ns)
      maps.nmap(';wr', ':lua require("telescope.builtin").live_grep({ additional_args = function() return { "--type=ruby", "--glob=!spec" } end })<CR>', maps.ns)

      -- only javascript / typescript
      maps.nmap(';j', ':Telescope find_files find_command=rg,--ignore-case,--hidden,--files,--type=js,--type=ts<CR>', maps.ns)
      maps.nmap(';jr', ':lua require("telescope.builtin").live_grep({ additional_args = function() return { "--type=js", "--type=ts" } end })<CR>', maps.ns)

      -- Telescope-file-browser
      maps.nmap(
        'sf',
        function() open_file_browser('normal') end,
        maps.n
      )

      -- tab
      maps.nmap(
        'te',
        function()
          vim.cmd('tabedit')
          open_file_browser('insert')
        end,
        maps.n
      )
      -- Tabs
      maps.nmap('fl', ':tabnext<Return>', maps.s)
      maps.nmap('fj', ':tabprev<Return>', maps.s)

      telescope.setup({
        defaults = {
          initial_mode = 'insert',
          mappings = {
            i = {
              ['<Down>'] = telescope_actions.cycle_history_next,
              ['<Up>'] = telescope_actions.cycle_history_prev,
            },
            n = {
              ['q'] = telescope_actions.close
            },
          },
        },
        extensions = {
          file_browser = {
            hijack_netrw = true,
            mappings = {
              n = {
                ['h'] = file_browser_actions.goto_parent_dir,
              }
            }
          }
        }
      })
    end
  }

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
      maps.nmap('<Leader>gl', ':lua require("gitsigns").blame_line({ full = true })<CR>', maps.ns)
    end
  }

  -- Utils
  use {
    'alvan/vim-closetag',
    config = function()
      vim.g.closetag_filenames = '*.html,*.xhtml,*xml,*.phtml,*.erb,*.php,*.vue,*.js,*.jsx,*.ts,*.tsx'
    end
  }

  use {
    'Yggdroot/indentLine',
    config = function()
      vim.g.indentLine_fileTypeExclude = {'help', 'nerdtree', 'calendar', 'thumbnail', 'tweetvim', 'defx', 'TelescopePrompt'}
      vim.g.indentLine_color_term = '239'
      vim.g.indentLine_color_gui = '#708090'
      vim.g.indentLine_char_list = {'┊', '┊', '┊', '┊'}
    end
  }

  use {
    'preservim/nerdcommenter',
    config = function()
      -- デフォルトのキーマッピングをオフ
      vim.g.NERDCreateDefaultMappings = '0'
      -- コメントアウト時にスペースを1つ挿入
      vim.g.NERDSpaceDelims = '1'
      -- コメント記号を左に揃える
      vim.g.NERDDefaultAlign = 'left'
      -- fishのコメントアウトが対応していなかったので追加
      vim.g.NERDCustomDelimiters = { fish = { left = '#' } }

      maps.nmap('<Leader>f', '<Plug>NERDCommenterToggle', maps.none)
      maps.vmap('<Leader>f', '<Plug>NERDCommenterToggle', maps.none)
      -- コメントアウトしてインサートモード
      maps.nmap('<Leader>r', '<Plug>NERDCommenterAppend', maps.none)
      -- ブロックコメントアウト
      maps.nmap('<Leader>bf', '<Plug>NERDCommenterSexy', maps.none)
      maps.vmap('<Leader>bf', '<Plug>NERDCommenterSexy', maps.none)
    end
  }

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

      maps.nmap('<Leader>a', ':PrevimOpen<CR>', maps.n)
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

      maps.nmap('<Leader>y', ':StripWhitespace<CR>', maps.n)
    end
  }

  use {
    'numToStr/BufOnly.nvim',
    config = function()
      maps.nmap('<Leader>ba', ':BufOnly<CR>', maps.n)
    end
  }

  use {
    'windwp/nvim-spectre',
    config = function()
      require('spectre').setup()

      maps.nmap('<Leader>m', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', maps.ns)
      maps.nmap('<Leader>w', '<cmd>lua require("spectre").open_visual()<CR>', maps.ns)
    end
  }

  use 'mtdl9/vim-log-highlighting'

  use {
    'elzr/vim-json',
    ft = { 'json' },
    config = function()
      vim.g.vim_json_syntax_conceal = '0'
    end
  }

  use {
    'stephpy/vim-yaml',
    ft = { 'yaml' },
  }

  use {
    'kchmck/vim-coffee-script',
    ft = { 'coffee' },
  }

  use {
    'dag/vim-fish',
    ft = { 'fish' },
  }

  use {
    'cespare/vim-toml',
    ft = { 'toml' },
  }

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

  use {
    'neoclide/jsonc.vim',
    ft = { 'jsonc' },
  }

  use {
    'fatih/vim-go',
    ft = { 'go' },
    config = function()
      vim.g.go_disable_autoinstall = '1'
      maps.nmap('<Leader>gr', ':GoRun<CR>', maps.n)
    end
  }

  use {
    'tpope/vim-rails',
    ft = { 'ruby' },
    config = function()
      maps.nmap('<Leader>1', ':A<CR>', maps.n)
    end
  }

  use {
    'joker1007/vim-ruby-heredoc-syntax',
    ft = { 'ruby' },
  }

  use {
    'joker1007/vim-markdown-quote-syntax',
    ft = { 'markdown' },
  }

  use {
    'tbastos/vim-lua',
    ft = { 'lua' },
  }

  use {
    'pantharshit00/vim-prisma',
    ft = { 'prisma' },
  }

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
