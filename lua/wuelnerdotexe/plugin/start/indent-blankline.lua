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
  init = function() require("wuelnerdotexe.plugin.util").add_colorscheme_integration("indent-blankline") end,
  config = function()
    require("indent_blankline").setup({
      use_treesitter = true,
      show_current_context = true,
      show_current_context_start = true,
      show_trailing_blankline_indent = false,
      char = "▏",
      context_char = "▏",
      buftype_exclude = { "help", "loclist", "nofile", "prompt", "quickfix", "terminal" },
      filetype_exclude = { "", "list", "netrw" },
    })
  end,
}
