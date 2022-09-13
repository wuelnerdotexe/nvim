local M = {}

M.config = function()
  require('indent_blankline').setup({
    space_char_blankline = ' ',
    char_list = {
      '|', '¦', '┆', '┊', '│',
      '│', '│', '│', '│', '│',
    },
    char_highlight_list = {
        "EnfocadoIndentBlanklineIndent1",
        "EnfocadoIndentBlanklineIndent2",
        "EnfocadoIndentBlanklineIndent3",
        "EnfocadoIndentBlanklineIndent4",
        "EnfocadoIndentBlanklineIndent5",
        "EnfocadoIndentBlanklineIndent6"
    },
    use_treesitter = true,
    show_trailing_blankline_indent = false,
    filetype_exclude = {
      'checkhealth',
      'dashboard',
      'fern',
      'fugitive',
      'fugitiveblame',
      'help',
      'lspinfo',
      'mason',
      'packer',
      'null-ls-info'
    }
  })
end

return M

