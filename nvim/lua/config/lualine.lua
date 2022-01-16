require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'nord',
    component_separators = { '', '' },
    section_separators = { '', '' },
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      'branch',
      {
        'diff',
        colored = true
      }
    },
    lualine_c = {
      {
        'filename',
        file_status = true,
        path = 1
      }
    },
    lualine_x = {
      -- 'encoding',
      'fileformat',
      {
        'filetype',
        icon_only = true,
        colored = true
      }
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {
      { 'filename', file_status = true, path = 1 },
    },
    lualine_b = {
      { 'diff', colored = true }
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {  { 'filetype', icon_only = true, colored = false }}
  },
  tabline = {},
  extensions = {}
}
