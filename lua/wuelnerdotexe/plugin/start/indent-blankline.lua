return {
  "lukas-reineke/indent-blankline.nvim",
  cmd = {
    "IndentBlanklineDisable",
    "IndentBlanklineEnable",
    "IndentBlanklineRefresh",
    "IndentBlanklineRefreshScroll",
    "IndentBlanklineToggle",
  },
  event = "FileType",
  config = function()
    require("indent_blankline").setup({
      use_treesitter = true,
      show_current_context = true,
      show_current_context_start = true,
      show_trailing_blankline_indent = false,
      char = "▏",
      context_char = "▏",
      buftype_exclude = { "help", "loclist", "nofile", "prompt", "quickfix", "terminal" },
      filetype_exclude = vim.list_extend({ "", "list" }, require("wuelnerdotexe.plugin.config").uifiletypes),
    })
  end,
}
