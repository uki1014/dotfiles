-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/shimizu-yuki/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/shimizu-yuki/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/shimizu-yuki/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/shimizu-yuki/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/shimizu-yuki/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["BufOnly.nvim"] = {
    config = { "\27LJ\2\nK\0\0\5\0\5\0\b6\0\0\0009\0\1\0'\2\2\0'\3\3\0006\4\0\0009\4\4\4B\0\4\1K\0\1\0\6n\17:BufOnly<CR>\15<Leader>ba\tnmap\tmaps\0" },
    loaded = true,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/start/BufOnly.nvim",
    url = "https://github.com/numToStr/BufOnly.nvim"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/start/auto-pairs",
    url = "https://github.com/jiangmiao/auto-pairs"
  },
  ["coc.nvim"] = {
    config = { "\27LJ\2\nu\0\0\2\0\5\0\n6\0\0\0009\0\1\0004\1\0\0=\1\2\0006\0\0\0009\0\1\0009\0\2\0'\1\4\0=\1\3\0K\0\1\0\24:SplitIfNotOpen4COC coc.preferences.jumpCommand\20coc_user_config\6g\bvimü\1\0\0\6\0\b\2\0296\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\23\0\0\0\b\0\1\0X\1\15Ä6\1\1\0009\1\4\1'\3\3\0B\1\2\2\18\3\1\0009\1\5\1\18\4\0\0\18\5\0\0B\1\4\2\18\3\1\0009\1\6\1'\4\a\0B\1\3\2\15\0\1\0X\2\3Ä+\1\2\0L\1\2\0X\1\2Ä+\1\1\0L\1\2\0K\0\1\0\a%s\nmatch\bsub\fgetline\6.\bcol\afn\bvim\2\0π\1\0\0\6\0\v\0\0266\0\0\0009\0\1\0009\0\2\0005\2\3\0006\3\4\0B\0\3\2)\1\0\0\3\1\0\0X\0\vÄ6\0\0\0009\0\5\0'\2\6\0006\3\0\0009\3\1\0039\3\a\3'\5\b\0B\3\2\2&\2\3\2B\0\2\1X\0\5Ä6\0\0\0009\0\1\0009\0\t\0'\2\n\0B\0\2\1K\0\1\0\fdoHover\14CocAction\f<cword>\vexpand\6h\bcmd\rfiletype\1\3\0\0\bvim\thelp\nindex\afn\bvimö\r\1\0\5\0002\0}6\0\0\0009\0\1\0'\2\2\0'\3\3\0006\4\0\0009\4\4\4B\0\4\0016\0\0\0009\0\1\0'\2\5\0'\3\6\0006\4\0\0009\4\4\4B\0\4\0016\0\0\0009\0\1\0'\2\a\0'\3\b\0006\4\0\0009\4\4\4B\0\4\0016\0\0\0009\0\1\0'\2\t\0'\3\n\0006\4\0\0009\4\v\4B\0\4\0016\0\0\0009\0\1\0'\2\f\0'\3\r\0006\4\0\0009\4\v\4B\0\4\0016\0\0\0009\0\1\0'\2\14\0'\3\15\0006\4\0\0009\4\v\4B\0\4\0016\0\0\0009\0\1\0'\2\16\0'\3\17\0006\4\0\0009\4\v\4B\0\4\0016\0\0\0009\0\1\0'\2\18\0'\3\19\0006\4\0\0009\4\20\4B\0\4\0016\0\0\0009\0\21\0'\2\22\0'\3\23\0006\4\0\0009\4\24\4B\0\4\0016\0\25\0009\0\26\0'\2\27\0B\0\2\0016\0\25\0009\0\28\0009\0\29\0006\2\30\0B\0\2\2\14\0\0\0X\0\2Ä3\0\31\0007\0 \0003\0!\0007\0\"\0003\0#\0007\0$\0006\0\25\0009\0\26\0'\2%\0B\0\2\0016\0\25\0009\0\26\0'\2&\0B\0\2\0016\0\25\0009\0\26\0'\2'\0B\0\2\0016\0\25\0009\0\26\0'\2(\0B\0\2\0016\0\25\0009\0\26\0'\2)\0B\0\2\0016\0\25\0009\0\26\0'\2*\0B\0\2\0016\0\25\0009\0\26\0'\2+\0B\0\2\0016\0\25\0009\0\26\0'\2,\0B\0\2\0016\0\25\0009\0\26\0'\2-\0B\0\2\0016\0\25\0009\0.\0005\0010\0=\1/\0006\0\25\0009\0\26\0'\0021\0B\0\2\1K\0\1\0?command! -nargs=0 Prettier :CocCommand prettier.formatFile\1\r\0\0\17coc-tsserver\rcoc-flow\17coc-prettier\15coc-eslint\19coc-solargraph\fcoc-css\vcoc-sh\16coc-tabnine\19coc-cssmodules\26coc-styled-components\15coc-vimlsp\15coc-prisma\26coc_global_extensions\6gKau BufLeave *.{js,jsx,ts,tsx} call coc#config('eslint.enable', v:true)†\1au BufNewFile,BufReadPre,BufEnter *.{flow,config.js,config.copy.js,config.lib.js,config.style.js,config.proxy.js} call coc#config('eslint.enable', v:false))au FileType scss setl iskeyword+=@-@\16augroup ENDHau User CocJumpPlaceholder call CocActionAsync(\"showSignatureHelp\")Lau FileType typescript,json setl formatexpr=CocAction(\"formatSelected\")\bau!\20augroup mygroup<au CursorHold * silent call CocActionAsync(\"highlight\")\23show_documentation\0\21check_back_space\0\28coc_configure_and_start\0\rcoc_path\nempty\afn6let coc_path = globpath(&rtp, \"autoload/coc.vim\")\bcmd\bvim\ane*pumvisible() ? \"<C-y>\" : \"<C-g>u<CR>\"\t<CR>\timap\ans\":lua show_documentation()<CR>\6K\27<Plug>(coc-references)\agr\31<Plug>(coc-implementation)\agi <Plug>(coc-type-definition)\agy\6s\27<Plug>(coc-definition)\agd\28:call coc#refresh()<CR>\16<Leader>cre\20:CocOpenLog<CR>\16<Leader>col\6n!:call coc#util#install()<CR>\15<Leader>co\tnmap\tmaps\0" },
    loaded = true,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/start/coc.nvim",
    url = "https://github.com/neoclide/coc.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n£\1\0\0\5\0\b\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0'\2\5\0'\3\6\0006\4\3\0009\4\a\4B\0\4\1K\0\1\0\ans=:lua require(\"gitsigns\").blame_line({ full = true })<CR>\15<Leader>gl\tnmap\tmaps\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  indentLine = {
    config = { "\27LJ\2\nè\2\0\0\2\0\n\0\0176\0\0\0009\0\1\0005\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0006\0\0\0009\0\1\0005\1\t\0=\1\b\0K\0\1\0\1\5\0\0\b‚îä\b‚îä\b‚îä\b‚îä\25indentLine_char_list\f#708090\25indentLine_color_gui\b239\26indentLine_color_term\1\b\0\0\thelp\rnerdtree\rcalendar\14thumbnail\rtweetvim\tdefx\20TelescopePrompt\31indentLine_fileTypeExclude\6g\bvim\0" },
    loaded = true,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/start/indentLine",
    url = "https://github.com/Yggdroot/indentLine"
  },
  ["jsonc.vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/jsonc.vim",
    url = "https://github.com/neoclide/jsonc.vim"
  },
  ["lightline.vim"] = {
    config = { "\27LJ\2\n¸\3\0\0\5\0\24\0#6\0\0\0009\0\1\0005\1\3\0005\2\6\0004\3\3\0005\4\4\0>\4\1\0035\4\5\0>\4\2\3=\3\a\0024\3\4\0005\4\b\0>\4\1\0035\4\t\0>\4\2\0035\4\n\0>\4\3\3=\3\v\2=\2\f\0015\2\14\0004\3\3\0005\4\r\0>\4\1\3=\3\a\2=\2\15\0015\2\16\0=\2\17\0015\2\18\0=\2\19\0015\2\20\0=\2\21\0015\2\22\0=\2\23\1=\1\2\0K\0\1\0\17subseparator\1\0\2\tleft\bÓÇ±\nright\bÓÇ≥\14separator\1\0\2\tleft\bÓÇ∞\nright\bÓÇ≤\23component_function\1\0\2\rreadonly\15MyReadonly\rmodified\15MyModified\14component\1\0\1\rfilename\a%f\rinactive\1\0\0\1\4\0\0\rreadonly\rfilename\rmodified\vactive\nright\1\4\0\0\rcharcode\15fileformat\rfiletype\1\2\0\0\fpercent\1\2\0\0\rlineinfo\tleft\1\0\0\1\4\0\0\rreadonly\rfilename\rmodified\1\3\0\0\tmode\npaste\1\0\1\16colorscheme\fdefault\14lightline\6g\bvim\0" },
    loaded = true,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/start/lightline.vim",
    url = "https://github.com/itchyny/lightline.vim"
  },
  nerdcommenter = {
    config = { "\27LJ\2\nœ\3\0\0\5\0\22\00066\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0006\0\0\0009\0\1\0005\1\n\0005\2\t\0=\2\v\1=\1\b\0006\0\f\0009\0\r\0'\2\14\0'\3\15\0006\4\f\0009\4\16\4B\0\4\0016\0\f\0009\0\17\0'\2\14\0'\3\15\0006\4\f\0009\4\16\4B\0\4\0016\0\f\0009\0\r\0'\2\18\0'\3\19\0006\4\f\0009\4\16\4B\0\4\0016\0\f\0009\0\r\0'\2\20\0'\3\21\0006\4\f\0009\4\16\4B\0\4\0016\0\f\0009\0\17\0'\2\20\0'\3\21\0006\4\f\0009\4\16\4B\0\4\1K\0\1\0\28<Plug>NERDCommenterSexy\15<Leader>bf\30<Plug>NERDCommenterAppend\14<Leader>r\tvmap\tnone\30<Plug>NERDCommenterToggle\14<Leader>f\tnmap\tmaps\tfish\1\0\0\1\0\1\tleft\6#\25NERDCustomDelimiters\tleft\21NERDDefaultAlign\0061\20NERDSpaceDelims\0060\30NERDCreateDefaultMappings\6g\bvim\0" },
    loaded = true,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/start/nerdcommenter",
    url = "https://github.com/preservim/nerdcommenter"
  },
  ["nvim-spectre"] = {
    config = { "\27LJ\2\n¸\1\0\0\5\0\n\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0'\2\5\0'\3\6\0006\4\3\0009\4\a\4B\0\4\0016\0\3\0009\0\4\0'\2\b\0'\3\t\0006\4\3\0009\4\a\4B\0\4\1K\0\1\0002<cmd>lua require(\"spectre\").open_visual()<CR>\14<Leader>w\ansD<cmd>lua require(\"spectre\").open_visual({select_word=true})<CR>\14<Leader>m\tnmap\tmaps\nsetup\fspectre\frequire\0" },
    loaded = true,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/start/nvim-spectre",
    url = "https://github.com/windwp/nvim-spectre"
  },
  ["packer.nvim"] = {
    config = { "\27LJ\2\nà\1\0\0\5\0\a\0\0156\0\0\0009\0\1\0'\2\2\0'\3\3\0006\4\0\0009\4\4\4B\0\4\0016\0\0\0009\0\1\0'\2\5\0'\3\6\0006\4\0\0009\4\4\4B\0\4\1K\0\1\0\20:PackerSync<CR>\15<Leader>ud\6n\23:PackerCompile<CR>\15<Leader>uf\tnmap\tmaps\0" },
    loaded = true,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  previm = {
    config = { "\27LJ\2\nã\1\0\0\5\0\t\0\f6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\4\0009\0\5\0'\2\6\0'\3\a\0006\4\4\0009\4\b\4B\0\4\1K\0\1\0\6n\20:PrevimOpen<CR>\14<Leader>a\tnmap\tmaps\28open -a \"Google Chrome\"\20previm_open_cmd\6g\bvim\0" },
    loaded = true,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/start/previm",
    url = "https://github.com/previm/previm"
  },
  rainbow_csv = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/rainbow_csv",
    url = "https://github.com/mechatroner/rainbow_csv"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n/\0\0\3\0\4\0\0056\0\0\0009\0\1\0009\0\2\0'\2\3\0D\0\2\0\n%:p:h\vexpand\afn\bvimΩ\1\0\1\6\2\5\0\v-\1\0\0009\1\0\0019\1\1\0019\1\1\0015\3\2\0-\4\1\0B\4\1\2=\4\3\3=\0\4\3B\1\2\1K\0\1\0\0¿\3¿\17initial_mode\bcwd\1\0\a\rdir_icon\b‚ñ∏\tpath\n%:p:h\18select_buffer\2\vhidden\1\18all_previewer\2\fgrouped\2\22respect_gitignore\1\17file_browser\15extensions \0\0\3\1\1\0\4-\0\0\0'\2\0\0B\0\2\1K\0\1\0\4¿\vnormal@\0\0\3\1\4\0\b6\0\0\0009\0\1\0'\2\2\0B\0\2\1-\0\0\0'\2\3\0B\0\2\1K\0\1\0\4¿\vinsert\ftabedit\bcmd\bvim™\15\1\0\r\0C\0õ\0016\0\0\0'\2\1\0B\0\2\0029\1\2\0'\3\3\0B\1\2\0016\1\0\0'\3\4\0B\1\2\0029\2\5\0009\2\3\0029\2\6\0023\3\a\0003\4\b\0006\5\t\0009\5\n\5'\a\v\0'\b\f\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a\14\0'\b\15\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a\16\0'\b\17\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a\18\0'\b\19\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a\20\0'\b\21\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a\22\0'\b\23\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a\24\0'\b\25\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a\26\0'\b\27\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a\28\0'\b\29\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a\30\0'\b\31\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a \0'\b!\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a\"\0'\b#\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a$\0003\b%\0006\t\t\0009\t&\tB\5\4\0016\5\t\0009\5\n\5'\a'\0003\b(\0006\t\t\0009\t&\tB\5\4\0016\5\t\0009\5\n\5'\a)\0'\b*\0006\t\t\0009\t+\tB\5\4\0016\5\t\0009\5\n\5'\a,\0'\b-\0006\t\t\0009\t+\tB\5\4\0019\5.\0005\a;\0005\b/\0005\t5\0005\n1\0009\v0\1=\v2\n9\v3\1=\v4\n=\n6\t5\n8\0009\v7\1=\v9\n=\n&\t=\t:\b=\b<\a5\bB\0005\t=\0005\nA\0005\v?\0009\f>\2=\f@\v=\v&\n=\n:\t=\t\3\b=\b\5\aB\5\2\0012\0\0ÄK\0\1\0\1\0\0\1\0\0\6h\1\0\0\20goto_parent_dir\1\0\1\17hijack_netrw\2\rdefaults\1\0\0\rmappings\6q\1\0\0\nclose\6i\1\0\0\t<Up>\23cycle_history_prev\v<Down>\1\0\0\23cycle_history_next\1\0\1\17initial_mode\vinsert\nsetup\21:tabprev<Return>\afj\6s\21:tabnext<Return>\afl\0\ate\6n\0\asf~:lua require(\"telescope.builtin\").live_grep({ additional_args = function() return { \"--type=js\", \"--type=ts\" } end })<CR>\b;jra:Telescope find_files find_command=rg,--ignore-case,--hidden,--files,--type=js,--type=ts<CR>\a;jÉ\1:lua require(\"telescope.builtin\").live_grep({ additional_args = function() return { \"--type=ruby\", \"--glob=!spec\" } end })<CR>\b;wrf:Telescope find_files find_command=rg,--ignore-case,--hidden,--files,--type=ruby,--glob=!spec<CR>\a;ws:lua require(\"telescope.builtin\").live_grep({ additional_args = function() return { \"--type=ruby\" } end })<CR>\b;hrY:Telescope find_files find_command=rg,--ignore-case,--hidden,--files,--type=ruby<CR>\a;h\27:Telescope buffers<CR>\a;e<:lua require(\"telescope.builtin\").command_history{}<CR>\a;c3:lua require(\"telescope.builtin\").resume()<CR>\a;tN:Telescope grep_string find_command=rg,--ignore-case,--hidden,--files<CR>\a;;L:Telescope live_grep find_command=rg,--ignore-case,--hidden,--files<CR>\a;r\ansM:Telescope find_files find_command=rg,--ignore-case,--hidden,--files<CR>\a;f\tnmap\tmaps\0\0\factions\15extensions\22telescope.actions\17file_browser\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["typescript-vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/typescript-vim",
    url = "https://github.com/leafgarland/typescript-vim"
  },
  ["vim-better-whitespace"] = {
    config = { "\27LJ\2\n¥\1\0\0\5\0\n\0\0166\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0006\0\5\0009\0\6\0'\2\a\0'\3\b\0006\4\5\0009\4\t\4B\0\4\1K\0\1\0\6n\25:StripWhitespace<CR>\14<Leader>y\tnmap\tmaps\29strip_whitespace_on_save\fdarkred\31better_whitespace_guicolor\6g\bvim\0" },
    loaded = true,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/start/vim-better-whitespace",
    url = "https://github.com/ntpeters/vim-better-whitespace"
  },
  ["vim-closetag"] = {
    config = { "\27LJ\2\nx\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0H*.html,*.xhtml,*xml,*.phtml,*.erb,*.php,*.vue,*.js,*.jsx,*.ts,*.tsx\23closetag_filenames\6g\bvim\0" },
    loaded = true,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/start/vim-closetag",
    url = "https://github.com/alvan/vim-closetag"
  },
  ["vim-coffee-script"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-coffee-script",
    url = "https://github.com/kchmck/vim-coffee-script"
  },
  ["vim-css-color"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-css-color",
    url = "https://github.com/ap/vim-css-color"
  },
  ["vim-fish"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-fish",
    url = "https://github.com/dag/vim-fish"
  },
  ["vim-go"] = {
    config = { "\27LJ\2\nx\0\0\5\0\t\0\f6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\4\0009\0\5\0'\2\6\0'\3\a\0006\4\4\0009\4\b\4B\0\4\1K\0\1\0\6n\15:GoRun<CR>\15<Leader>gr\tnmap\tmaps\0061\27go_disable_autoinstall\6g\bvim\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-go",
    url = "https://github.com/fatih/vim-go"
  },
  ["vim-graphql"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-graphql",
    url = "https://github.com/jparise/vim-graphql"
  },
  ["vim-js"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-js",
    url = "https://github.com/yuezk/vim-js"
  },
  ["vim-json"] = {
    config = { "\27LJ\2\n;\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\0060\28vim_json_syntax_conceal\6g\bvim\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-json",
    url = "https://github.com/elzr/vim-json"
  },
  ["vim-jsx-pretty"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-jsx-pretty",
    url = "https://github.com/maxmellon/vim-jsx-pretty"
  },
  ["vim-log-highlighting"] = {
    loaded = true,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/start/vim-log-highlighting",
    url = "https://github.com/mtdl9/vim-log-highlighting"
  },
  ["vim-lua"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-lua",
    url = "https://github.com/tbastos/vim-lua"
  },
  ["vim-markdown-quote-syntax"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-markdown-quote-syntax",
    url = "https://github.com/joker1007/vim-markdown-quote-syntax"
  },
  ["vim-prisma"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-prisma",
    url = "https://github.com/pantharshit00/vim-prisma"
  },
  ["vim-rails"] = {
    config = { "\27LJ\2\nD\0\0\5\0\5\0\b6\0\0\0009\0\1\0'\2\2\0'\3\3\0006\4\0\0009\4\4\4B\0\4\1K\0\1\0\6n\v:A<CR>\14<Leader>1\tnmap\tmaps\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-rails",
    url = "https://github.com/tpope/vim-rails"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-ruby-heredoc-syntax"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-ruby-heredoc-syntax",
    url = "https://github.com/joker1007/vim-ruby-heredoc-syntax"
  },
  ["vim-styled-components"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-styled-components",
    url = "https://github.com/styled-components/vim-styled-components"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-to-github"] = {
    config = { "\27LJ\2\nÓ\3\0\0\5\0\19\0/6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\4\0009\0\5\0'\2\6\0'\3\a\0006\4\4\0009\4\b\4B\0\4\0016\0\4\0009\0\5\0'\2\t\0'\3\n\0006\4\4\0009\4\b\4B\0\4\0016\0\4\0009\0\5\0'\2\v\0'\3\f\0006\4\4\0009\4\b\4B\0\4\0016\0\4\0009\0\5\0'\2\r\0'\3\14\0006\4\4\0009\4\b\4B\0\4\0016\0\4\0009\0\5\0'\2\15\0'\3\16\0006\4\4\0009\4\b\4B\0\4\0016\0\4\0009\0\5\0'\2\17\0'\3\18\0006\4\4\0009\4\b\4B\0\4\1K\0\1\0001:ToGithubTargetPullRequestFromCommitHash<CR>\14<Leader>j#:ToGithubTargetPullRequest<CR>\14<Leader>g!:ToGithubBlameCommitHash<CR>\15<Leader>GB :ToGithubBlobCommitHash<CR>\14<Leader>G$:ToGithubBlameDevelopBranch<CR>\15<Leader>gb\6n#:ToGithubBlobDevelopBranch<CR>\15<Leader>gj\tnmap\tmaps\0061\24to_github_clipboard\6g\bvim\0" },
    loaded = true,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/start/vim-to-github",
    url = "https://github.com/uki1014/vim-to-github"
  },
  ["vim-toml"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-toml",
    url = "https://github.com/cespare/vim-toml"
  },
  ["vim-workspace"] = {
    config = { "\27LJ\2\n˙\1\0\0\4\0\f\0\0276\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0006\1\5\0009\1\6\1'\3\a\0B\1\2\2'\2\b\0&\1\2\1=\1\4\0006\0\0\0009\0\1\0'\1\n\0=\1\t\0006\0\0\0009\0\1\0006\1\5\0009\1\6\1'\3\a\0B\1\2\2'\2\b\0&\1\2\1=\1\v\0K\0\1\0 workspace_session_directory\0060\23workspace_autosave\28/.config/nvim/sessions/\tHOME\vgetenv\aos\22workspace_undodir\0061\25workspace_autocreate\6g\bvim\0" },
    loaded = true,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/start/vim-workspace",
    url = "https://github.com/thaerkh/vim-workspace"
  },
  ["vim-yaml"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-yaml",
    url = "https://github.com/stephpy/vim-yaml"
  },
  ["vim-zenspace"] = {
    config = { "\27LJ\2\n:\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\aon\26zenspace#default_mode\6g\bvim\0" },
    loaded = true,
    path = "/home/shimizu-yuki/.local/share/nvim/site/pack/packer/start/vim-zenspace",
    url = "https://github.com/uki1014/vim-zenspace"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: coc.nvim
time([[Config for coc.nvim]], true)
try_loadstring("\27LJ\2\nu\0\0\2\0\5\0\n6\0\0\0009\0\1\0004\1\0\0=\1\2\0006\0\0\0009\0\1\0009\0\2\0'\1\4\0=\1\3\0K\0\1\0\24:SplitIfNotOpen4COC coc.preferences.jumpCommand\20coc_user_config\6g\bvimü\1\0\0\6\0\b\2\0296\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\23\0\0\0\b\0\1\0X\1\15Ä6\1\1\0009\1\4\1'\3\3\0B\1\2\2\18\3\1\0009\1\5\1\18\4\0\0\18\5\0\0B\1\4\2\18\3\1\0009\1\6\1'\4\a\0B\1\3\2\15\0\1\0X\2\3Ä+\1\2\0L\1\2\0X\1\2Ä+\1\1\0L\1\2\0K\0\1\0\a%s\nmatch\bsub\fgetline\6.\bcol\afn\bvim\2\0π\1\0\0\6\0\v\0\0266\0\0\0009\0\1\0009\0\2\0005\2\3\0006\3\4\0B\0\3\2)\1\0\0\3\1\0\0X\0\vÄ6\0\0\0009\0\5\0'\2\6\0006\3\0\0009\3\1\0039\3\a\3'\5\b\0B\3\2\2&\2\3\2B\0\2\1X\0\5Ä6\0\0\0009\0\1\0009\0\t\0'\2\n\0B\0\2\1K\0\1\0\fdoHover\14CocAction\f<cword>\vexpand\6h\bcmd\rfiletype\1\3\0\0\bvim\thelp\nindex\afn\bvimö\r\1\0\5\0002\0}6\0\0\0009\0\1\0'\2\2\0'\3\3\0006\4\0\0009\4\4\4B\0\4\0016\0\0\0009\0\1\0'\2\5\0'\3\6\0006\4\0\0009\4\4\4B\0\4\0016\0\0\0009\0\1\0'\2\a\0'\3\b\0006\4\0\0009\4\4\4B\0\4\0016\0\0\0009\0\1\0'\2\t\0'\3\n\0006\4\0\0009\4\v\4B\0\4\0016\0\0\0009\0\1\0'\2\f\0'\3\r\0006\4\0\0009\4\v\4B\0\4\0016\0\0\0009\0\1\0'\2\14\0'\3\15\0006\4\0\0009\4\v\4B\0\4\0016\0\0\0009\0\1\0'\2\16\0'\3\17\0006\4\0\0009\4\v\4B\0\4\0016\0\0\0009\0\1\0'\2\18\0'\3\19\0006\4\0\0009\4\20\4B\0\4\0016\0\0\0009\0\21\0'\2\22\0'\3\23\0006\4\0\0009\4\24\4B\0\4\0016\0\25\0009\0\26\0'\2\27\0B\0\2\0016\0\25\0009\0\28\0009\0\29\0006\2\30\0B\0\2\2\14\0\0\0X\0\2Ä3\0\31\0007\0 \0003\0!\0007\0\"\0003\0#\0007\0$\0006\0\25\0009\0\26\0'\2%\0B\0\2\0016\0\25\0009\0\26\0'\2&\0B\0\2\0016\0\25\0009\0\26\0'\2'\0B\0\2\0016\0\25\0009\0\26\0'\2(\0B\0\2\0016\0\25\0009\0\26\0'\2)\0B\0\2\0016\0\25\0009\0\26\0'\2*\0B\0\2\0016\0\25\0009\0\26\0'\2+\0B\0\2\0016\0\25\0009\0\26\0'\2,\0B\0\2\0016\0\25\0009\0\26\0'\2-\0B\0\2\0016\0\25\0009\0.\0005\0010\0=\1/\0006\0\25\0009\0\26\0'\0021\0B\0\2\1K\0\1\0?command! -nargs=0 Prettier :CocCommand prettier.formatFile\1\r\0\0\17coc-tsserver\rcoc-flow\17coc-prettier\15coc-eslint\19coc-solargraph\fcoc-css\vcoc-sh\16coc-tabnine\19coc-cssmodules\26coc-styled-components\15coc-vimlsp\15coc-prisma\26coc_global_extensions\6gKau BufLeave *.{js,jsx,ts,tsx} call coc#config('eslint.enable', v:true)†\1au BufNewFile,BufReadPre,BufEnter *.{flow,config.js,config.copy.js,config.lib.js,config.style.js,config.proxy.js} call coc#config('eslint.enable', v:false))au FileType scss setl iskeyword+=@-@\16augroup ENDHau User CocJumpPlaceholder call CocActionAsync(\"showSignatureHelp\")Lau FileType typescript,json setl formatexpr=CocAction(\"formatSelected\")\bau!\20augroup mygroup<au CursorHold * silent call CocActionAsync(\"highlight\")\23show_documentation\0\21check_back_space\0\28coc_configure_and_start\0\rcoc_path\nempty\afn6let coc_path = globpath(&rtp, \"autoload/coc.vim\")\bcmd\bvim\ane*pumvisible() ? \"<C-y>\" : \"<C-g>u<CR>\"\t<CR>\timap\ans\":lua show_documentation()<CR>\6K\27<Plug>(coc-references)\agr\31<Plug>(coc-implementation)\agi <Plug>(coc-type-definition)\agy\6s\27<Plug>(coc-definition)\agd\28:call coc#refresh()<CR>\16<Leader>cre\20:CocOpenLog<CR>\16<Leader>col\6n!:call coc#util#install()<CR>\15<Leader>co\tnmap\tmaps\0", "config", "coc.nvim")
time([[Config for coc.nvim]], false)
-- Config for: vim-better-whitespace
time([[Config for vim-better-whitespace]], true)
try_loadstring("\27LJ\2\n¥\1\0\0\5\0\n\0\0166\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0006\0\5\0009\0\6\0'\2\a\0'\3\b\0006\4\5\0009\4\t\4B\0\4\1K\0\1\0\6n\25:StripWhitespace<CR>\14<Leader>y\tnmap\tmaps\29strip_whitespace_on_save\fdarkred\31better_whitespace_guicolor\6g\bvim\0", "config", "vim-better-whitespace")
time([[Config for vim-better-whitespace]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n£\1\0\0\5\0\b\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0'\2\5\0'\3\6\0006\4\3\0009\4\a\4B\0\4\1K\0\1\0\ans=:lua require(\"gitsigns\").blame_line({ full = true })<CR>\15<Leader>gl\tnmap\tmaps\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: nerdcommenter
time([[Config for nerdcommenter]], true)
try_loadstring("\27LJ\2\nœ\3\0\0\5\0\22\00066\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0006\0\0\0009\0\1\0005\1\n\0005\2\t\0=\2\v\1=\1\b\0006\0\f\0009\0\r\0'\2\14\0'\3\15\0006\4\f\0009\4\16\4B\0\4\0016\0\f\0009\0\17\0'\2\14\0'\3\15\0006\4\f\0009\4\16\4B\0\4\0016\0\f\0009\0\r\0'\2\18\0'\3\19\0006\4\f\0009\4\16\4B\0\4\0016\0\f\0009\0\r\0'\2\20\0'\3\21\0006\4\f\0009\4\16\4B\0\4\0016\0\f\0009\0\17\0'\2\20\0'\3\21\0006\4\f\0009\4\16\4B\0\4\1K\0\1\0\28<Plug>NERDCommenterSexy\15<Leader>bf\30<Plug>NERDCommenterAppend\14<Leader>r\tvmap\tnone\30<Plug>NERDCommenterToggle\14<Leader>f\tnmap\tmaps\tfish\1\0\0\1\0\1\tleft\6#\25NERDCustomDelimiters\tleft\21NERDDefaultAlign\0061\20NERDSpaceDelims\0060\30NERDCreateDefaultMappings\6g\bvim\0", "config", "nerdcommenter")
time([[Config for nerdcommenter]], false)
-- Config for: vim-closetag
time([[Config for vim-closetag]], true)
try_loadstring("\27LJ\2\nx\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0H*.html,*.xhtml,*xml,*.phtml,*.erb,*.php,*.vue,*.js,*.jsx,*.ts,*.tsx\23closetag_filenames\6g\bvim\0", "config", "vim-closetag")
time([[Config for vim-closetag]], false)
-- Config for: vim-workspace
time([[Config for vim-workspace]], true)
try_loadstring("\27LJ\2\n˙\1\0\0\4\0\f\0\0276\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0006\1\5\0009\1\6\1'\3\a\0B\1\2\2'\2\b\0&\1\2\1=\1\4\0006\0\0\0009\0\1\0'\1\n\0=\1\t\0006\0\0\0009\0\1\0006\1\5\0009\1\6\1'\3\a\0B\1\2\2'\2\b\0&\1\2\1=\1\v\0K\0\1\0 workspace_session_directory\0060\23workspace_autosave\28/.config/nvim/sessions/\tHOME\vgetenv\aos\22workspace_undodir\0061\25workspace_autocreate\6g\bvim\0", "config", "vim-workspace")
time([[Config for vim-workspace]], false)
-- Config for: indentLine
time([[Config for indentLine]], true)
try_loadstring("\27LJ\2\nè\2\0\0\2\0\n\0\0176\0\0\0009\0\1\0005\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0006\0\0\0009\0\1\0005\1\t\0=\1\b\0K\0\1\0\1\5\0\0\b‚îä\b‚îä\b‚îä\b‚îä\25indentLine_char_list\f#708090\25indentLine_color_gui\b239\26indentLine_color_term\1\b\0\0\thelp\rnerdtree\rcalendar\14thumbnail\rtweetvim\tdefx\20TelescopePrompt\31indentLine_fileTypeExclude\6g\bvim\0", "config", "indentLine")
time([[Config for indentLine]], false)
-- Config for: nvim-spectre
time([[Config for nvim-spectre]], true)
try_loadstring("\27LJ\2\n¸\1\0\0\5\0\n\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0'\2\5\0'\3\6\0006\4\3\0009\4\a\4B\0\4\0016\0\3\0009\0\4\0'\2\b\0'\3\t\0006\4\3\0009\4\a\4B\0\4\1K\0\1\0002<cmd>lua require(\"spectre\").open_visual()<CR>\14<Leader>w\ansD<cmd>lua require(\"spectre\").open_visual({select_word=true})<CR>\14<Leader>m\tnmap\tmaps\nsetup\fspectre\frequire\0", "config", "nvim-spectre")
time([[Config for nvim-spectre]], false)
-- Config for: lightline.vim
time([[Config for lightline.vim]], true)
try_loadstring("\27LJ\2\n¸\3\0\0\5\0\24\0#6\0\0\0009\0\1\0005\1\3\0005\2\6\0004\3\3\0005\4\4\0>\4\1\0035\4\5\0>\4\2\3=\3\a\0024\3\4\0005\4\b\0>\4\1\0035\4\t\0>\4\2\0035\4\n\0>\4\3\3=\3\v\2=\2\f\0015\2\14\0004\3\3\0005\4\r\0>\4\1\3=\3\a\2=\2\15\0015\2\16\0=\2\17\0015\2\18\0=\2\19\0015\2\20\0=\2\21\0015\2\22\0=\2\23\1=\1\2\0K\0\1\0\17subseparator\1\0\2\tleft\bÓÇ±\nright\bÓÇ≥\14separator\1\0\2\tleft\bÓÇ∞\nright\bÓÇ≤\23component_function\1\0\2\rreadonly\15MyReadonly\rmodified\15MyModified\14component\1\0\1\rfilename\a%f\rinactive\1\0\0\1\4\0\0\rreadonly\rfilename\rmodified\vactive\nright\1\4\0\0\rcharcode\15fileformat\rfiletype\1\2\0\0\fpercent\1\2\0\0\rlineinfo\tleft\1\0\0\1\4\0\0\rreadonly\rfilename\rmodified\1\3\0\0\tmode\npaste\1\0\1\16colorscheme\fdefault\14lightline\6g\bvim\0", "config", "lightline.vim")
time([[Config for lightline.vim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n/\0\0\3\0\4\0\0056\0\0\0009\0\1\0009\0\2\0'\2\3\0D\0\2\0\n%:p:h\vexpand\afn\bvimΩ\1\0\1\6\2\5\0\v-\1\0\0009\1\0\0019\1\1\0019\1\1\0015\3\2\0-\4\1\0B\4\1\2=\4\3\3=\0\4\3B\1\2\1K\0\1\0\0¿\3¿\17initial_mode\bcwd\1\0\a\rdir_icon\b‚ñ∏\tpath\n%:p:h\18select_buffer\2\vhidden\1\18all_previewer\2\fgrouped\2\22respect_gitignore\1\17file_browser\15extensions \0\0\3\1\1\0\4-\0\0\0'\2\0\0B\0\2\1K\0\1\0\4¿\vnormal@\0\0\3\1\4\0\b6\0\0\0009\0\1\0'\2\2\0B\0\2\1-\0\0\0'\2\3\0B\0\2\1K\0\1\0\4¿\vinsert\ftabedit\bcmd\bvim™\15\1\0\r\0C\0õ\0016\0\0\0'\2\1\0B\0\2\0029\1\2\0'\3\3\0B\1\2\0016\1\0\0'\3\4\0B\1\2\0029\2\5\0009\2\3\0029\2\6\0023\3\a\0003\4\b\0006\5\t\0009\5\n\5'\a\v\0'\b\f\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a\14\0'\b\15\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a\16\0'\b\17\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a\18\0'\b\19\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a\20\0'\b\21\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a\22\0'\b\23\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a\24\0'\b\25\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a\26\0'\b\27\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a\28\0'\b\29\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a\30\0'\b\31\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a \0'\b!\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a\"\0'\b#\0006\t\t\0009\t\r\tB\5\4\0016\5\t\0009\5\n\5'\a$\0003\b%\0006\t\t\0009\t&\tB\5\4\0016\5\t\0009\5\n\5'\a'\0003\b(\0006\t\t\0009\t&\tB\5\4\0016\5\t\0009\5\n\5'\a)\0'\b*\0006\t\t\0009\t+\tB\5\4\0016\5\t\0009\5\n\5'\a,\0'\b-\0006\t\t\0009\t+\tB\5\4\0019\5.\0005\a;\0005\b/\0005\t5\0005\n1\0009\v0\1=\v2\n9\v3\1=\v4\n=\n6\t5\n8\0009\v7\1=\v9\n=\n&\t=\t:\b=\b<\a5\bB\0005\t=\0005\nA\0005\v?\0009\f>\2=\f@\v=\v&\n=\n:\t=\t\3\b=\b\5\aB\5\2\0012\0\0ÄK\0\1\0\1\0\0\1\0\0\6h\1\0\0\20goto_parent_dir\1\0\1\17hijack_netrw\2\rdefaults\1\0\0\rmappings\6q\1\0\0\nclose\6i\1\0\0\t<Up>\23cycle_history_prev\v<Down>\1\0\0\23cycle_history_next\1\0\1\17initial_mode\vinsert\nsetup\21:tabprev<Return>\afj\6s\21:tabnext<Return>\afl\0\ate\6n\0\asf~:lua require(\"telescope.builtin\").live_grep({ additional_args = function() return { \"--type=js\", \"--type=ts\" } end })<CR>\b;jra:Telescope find_files find_command=rg,--ignore-case,--hidden,--files,--type=js,--type=ts<CR>\a;jÉ\1:lua require(\"telescope.builtin\").live_grep({ additional_args = function() return { \"--type=ruby\", \"--glob=!spec\" } end })<CR>\b;wrf:Telescope find_files find_command=rg,--ignore-case,--hidden,--files,--type=ruby,--glob=!spec<CR>\a;ws:lua require(\"telescope.builtin\").live_grep({ additional_args = function() return { \"--type=ruby\" } end })<CR>\b;hrY:Telescope find_files find_command=rg,--ignore-case,--hidden,--files,--type=ruby<CR>\a;h\27:Telescope buffers<CR>\a;e<:lua require(\"telescope.builtin\").command_history{}<CR>\a;c3:lua require(\"telescope.builtin\").resume()<CR>\a;tN:Telescope grep_string find_command=rg,--ignore-case,--hidden,--files<CR>\a;;L:Telescope live_grep find_command=rg,--ignore-case,--hidden,--files<CR>\a;r\ansM:Telescope find_files find_command=rg,--ignore-case,--hidden,--files<CR>\a;f\tnmap\tmaps\0\0\factions\15extensions\22telescope.actions\17file_browser\19load_extension\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: vim-zenspace
time([[Config for vim-zenspace]], true)
try_loadstring("\27LJ\2\n:\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\aon\26zenspace#default_mode\6g\bvim\0", "config", "vim-zenspace")
time([[Config for vim-zenspace]], false)
-- Config for: BufOnly.nvim
time([[Config for BufOnly.nvim]], true)
try_loadstring("\27LJ\2\nK\0\0\5\0\5\0\b6\0\0\0009\0\1\0'\2\2\0'\3\3\0006\4\0\0009\4\4\4B\0\4\1K\0\1\0\6n\17:BufOnly<CR>\15<Leader>ba\tnmap\tmaps\0", "config", "BufOnly.nvim")
time([[Config for BufOnly.nvim]], false)
-- Config for: packer.nvim
time([[Config for packer.nvim]], true)
try_loadstring("\27LJ\2\nà\1\0\0\5\0\a\0\0156\0\0\0009\0\1\0'\2\2\0'\3\3\0006\4\0\0009\4\4\4B\0\4\0016\0\0\0009\0\1\0'\2\5\0'\3\6\0006\4\0\0009\4\4\4B\0\4\1K\0\1\0\20:PackerSync<CR>\15<Leader>ud\6n\23:PackerCompile<CR>\15<Leader>uf\tnmap\tmaps\0", "config", "packer.nvim")
time([[Config for packer.nvim]], false)
-- Config for: previm
time([[Config for previm]], true)
try_loadstring("\27LJ\2\nã\1\0\0\5\0\t\0\f6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\4\0009\0\5\0'\2\6\0'\3\a\0006\4\4\0009\4\b\4B\0\4\1K\0\1\0\6n\20:PrevimOpen<CR>\14<Leader>a\tnmap\tmaps\28open -a \"Google Chrome\"\20previm_open_cmd\6g\bvim\0", "config", "previm")
time([[Config for previm]], false)
-- Config for: vim-to-github
time([[Config for vim-to-github]], true)
try_loadstring("\27LJ\2\nÓ\3\0\0\5\0\19\0/6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\4\0009\0\5\0'\2\6\0'\3\a\0006\4\4\0009\4\b\4B\0\4\0016\0\4\0009\0\5\0'\2\t\0'\3\n\0006\4\4\0009\4\b\4B\0\4\0016\0\4\0009\0\5\0'\2\v\0'\3\f\0006\4\4\0009\4\b\4B\0\4\0016\0\4\0009\0\5\0'\2\r\0'\3\14\0006\4\4\0009\4\b\4B\0\4\0016\0\4\0009\0\5\0'\2\15\0'\3\16\0006\4\4\0009\4\b\4B\0\4\0016\0\4\0009\0\5\0'\2\17\0'\3\18\0006\4\4\0009\4\b\4B\0\4\1K\0\1\0001:ToGithubTargetPullRequestFromCommitHash<CR>\14<Leader>j#:ToGithubTargetPullRequest<CR>\14<Leader>g!:ToGithubBlameCommitHash<CR>\15<Leader>GB :ToGithubBlobCommitHash<CR>\14<Leader>G$:ToGithubBlameDevelopBranch<CR>\15<Leader>gb\6n#:ToGithubBlobDevelopBranch<CR>\15<Leader>gj\tnmap\tmaps\0061\24to_github_clipboard\6g\bvim\0", "config", "vim-to-github")
time([[Config for vim-to-github]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType ruby ++once lua require("packer.load")({'vim-rails', 'vim-ruby-heredoc-syntax'}, { ft = "ruby" }, _G.packer_plugins)]]
vim.cmd [[au FileType go ++once lua require("packer.load")({'vim-go'}, { ft = "go" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-markdown-quote-syntax'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType prisma ++once lua require("packer.load")({'vim-prisma'}, { ft = "prisma" }, _G.packer_plugins)]]
vim.cmd [[au FileType coffee ++once lua require("packer.load")({'vim-coffee-script'}, { ft = "coffee" }, _G.packer_plugins)]]
vim.cmd [[au FileType jsonc ++once lua require("packer.load")({'jsonc.vim'}, { ft = "jsonc" }, _G.packer_plugins)]]
vim.cmd [[au FileType yaml ++once lua require("packer.load")({'vim-yaml'}, { ft = "yaml" }, _G.packer_plugins)]]
vim.cmd [[au FileType toml ++once lua require("packer.load")({'vim-toml'}, { ft = "toml" }, _G.packer_plugins)]]
vim.cmd [[au FileType less ++once lua require("packer.load")({'vim-css-color'}, { ft = "less" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'vim-graphql', 'vim-js', 'vim-jsx-pretty', 'vim-styled-components', 'vim-css-color'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript.jsx ++once lua require("packer.load")({'vim-graphql', 'vim-js', 'vim-jsx-pretty', 'vim-styled-components', 'vim-css-color'}, { ft = "javascript.jsx" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascriptreact ++once lua require("packer.load")({'vim-graphql', 'vim-js', 'vim-jsx-pretty', 'vim-styled-components', 'vim-css-color'}, { ft = "javascriptreact" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'vim-graphql', 'vim-js', 'vim-jsx-pretty', 'vim-styled-components', 'typescript-vim', 'vim-css-color'}, { ft = "typescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript.tsx ++once lua require("packer.load")({'vim-graphql', 'vim-js', 'vim-jsx-pretty', 'vim-styled-components', 'typescript-vim', 'vim-css-color'}, { ft = "typescript.tsx" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescriptreact ++once lua require("packer.load")({'vim-graphql', 'vim-js', 'vim-jsx-pretty', 'vim-styled-components', 'typescript-vim', 'vim-css-color'}, { ft = "typescriptreact" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'vim-css-color'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'vim-css-color'}, { ft = "css" }, _G.packer_plugins)]]
vim.cmd [[au FileType scss ++once lua require("packer.load")({'vim-css-color'}, { ft = "scss" }, _G.packer_plugins)]]
vim.cmd [[au FileType json ++once lua require("packer.load")({'vim-json'}, { ft = "json" }, _G.packer_plugins)]]
vim.cmd [[au FileType vim ++once lua require("packer.load")({'vim-css-color'}, { ft = "vim" }, _G.packer_plugins)]]
vim.cmd [[au FileType csv ++once lua require("packer.load")({'rainbow_csv'}, { ft = "csv" }, _G.packer_plugins)]]
vim.cmd [[au FileType tsv ++once lua require("packer.load")({'rainbow_csv'}, { ft = "tsv" }, _G.packer_plugins)]]
vim.cmd [[au FileType lua ++once lua require("packer.load")({'vim-lua', 'vim-css-color'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType fish ++once lua require("packer.load")({'vim-fish'}, { ft = "fish" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]], true)
vim.cmd [[source /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]]
time([[Sourcing ftdetect script at: /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]], false)
time([[Sourcing ftdetect script at: /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-graphql/ftdetect/graphql.vim]], true)
vim.cmd [[source /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-graphql/ftdetect/graphql.vim]]
time([[Sourcing ftdetect script at: /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-graphql/ftdetect/graphql.vim]], false)
time([[Sourcing ftdetect script at: /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-js/ftdetect/javascript.vim]], true)
vim.cmd [[source /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-js/ftdetect/javascript.vim]]
time([[Sourcing ftdetect script at: /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-js/ftdetect/javascript.vim]], false)
time([[Sourcing ftdetect script at: /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/jsonc.vim/ftdetect/jsonc.vim]], true)
vim.cmd [[source /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/jsonc.vim/ftdetect/jsonc.vim]]
time([[Sourcing ftdetect script at: /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/jsonc.vim/ftdetect/jsonc.vim]], false)
time([[Sourcing ftdetect script at: /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-json/ftdetect/json.vim]], true)
vim.cmd [[source /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-json/ftdetect/json.vim]]
time([[Sourcing ftdetect script at: /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-json/ftdetect/json.vim]], false)
time([[Sourcing ftdetect script at: /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-prisma/ftdetect/prisma.vim]], true)
vim.cmd [[source /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-prisma/ftdetect/prisma.vim]]
time([[Sourcing ftdetect script at: /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-prisma/ftdetect/prisma.vim]], false)
time([[Sourcing ftdetect script at: /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/typescript-vim/ftdetect/typescript.vim]], true)
vim.cmd [[source /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/typescript-vim/ftdetect/typescript.vim]]
time([[Sourcing ftdetect script at: /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/typescript-vim/ftdetect/typescript.vim]], false)
time([[Sourcing ftdetect script at: /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-toml/ftdetect/toml.vim]], true)
vim.cmd [[source /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-toml/ftdetect/toml.vim]]
time([[Sourcing ftdetect script at: /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-toml/ftdetect/toml.vim]], false)
time([[Sourcing ftdetect script at: /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-coffee-script/ftdetect/coffee.vim]], true)
vim.cmd [[source /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-coffee-script/ftdetect/coffee.vim]]
time([[Sourcing ftdetect script at: /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-coffee-script/ftdetect/coffee.vim]], false)
time([[Sourcing ftdetect script at: /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-coffee-script/ftdetect/vim-literate-coffeescript.vim]], true)
vim.cmd [[source /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-coffee-script/ftdetect/vim-literate-coffeescript.vim]]
time([[Sourcing ftdetect script at: /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-coffee-script/ftdetect/vim-literate-coffeescript.vim]], false)
time([[Sourcing ftdetect script at: /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-fish/ftdetect/fish.vim]], true)
vim.cmd [[source /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-fish/ftdetect/fish.vim]]
time([[Sourcing ftdetect script at: /home/shimizu-yuki/.local/share/nvim/site/pack/packer/opt/vim-fish/ftdetect/fish.vim]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
