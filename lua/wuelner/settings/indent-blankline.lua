local M = {}

M.config = function()
  require('indent_blankline').setup({
    use_treesitter = true,
    show_trailing_blankline_indent = false,
    space_char_blankline = ' ',
    char_list = {
      '|', '¦', '┆', '┊', '│',
      '│', '│', '│', '│', '│',
    },
    buftype_exclude = {
      'help',
      'loclist',
      'nofile',
      'prompt',
      'quickfix',
      'terminal'
    },
    filetype_exclude = { 'fugitive', 'fugitiveblame', 'list' }
  })
end

return M

