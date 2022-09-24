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
