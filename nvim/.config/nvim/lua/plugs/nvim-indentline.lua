utils = require('core.utils')

vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_buftype_exclude = {'terminal'}
vim.g.indent_blankline_filetype_exclude = {'','help', 'startify', 'dashboard', 'packer', 'sagahover', 'NvimTree'}
vim.g.indent_blankline_char = '▏'
-- vim.g.indent_blankline_char_list = { '|', '¦', '┆', '┊' }

vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_trailing_blankline_indent = false


