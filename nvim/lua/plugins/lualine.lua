require('lualine').setup {
  options = {
    icons_enabled = 0,
    lower = true,
    theme = 'powerline',
  },
  sections = {
    lualine_a = {
      {
        'mode',
        icon = nil,
        lower = false,
      }
    },
    lualine_b = {
      {
        'filename',
        file_status = true,
        path = 1,
        full_path = true,
        shorten = false
      },
    },
    lualine_x = { icon = nil, 'encoding', 'filetype' },
  },
  inactive_sections = {
    lualine_b = {
      {
        'filename',
        file_status = true,
        path = 1,
        full_path = true,
        shorten = false,
      },
    },
    lualine_c ={},
    lualine_x = { icon = nil, 'encoding', 'filetype' },
  }
}
