require('lualine').setup {
  options = {
    icons_enabled = 1,
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
  }
}
