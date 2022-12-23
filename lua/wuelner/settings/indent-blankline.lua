local M = {}

M.config = function()
  local char_list = { "|", "¦", "┆", "┊", "│", "│", "│", "│", "│", "│" }

  require("indent_blankline").setup({
    use_treesitter = true,
    show_current_context = true,
    show_trailing_blankline_indent = false,
    space_char_blankline = " ",
    char_list = char_list,
    context_char_list = char_list,
    buftype_exclude = {
      "help",
      "loclist",
      "nofile",
      "prompt",
      "quickfix",
      "terminal",
    },
    filetype_exclude = { "list" },
  })
end

return M
