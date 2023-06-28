return {
  "tzachar/highlight-undo.nvim",
  keys = { "u", "<C-r>" },
  init = function() require("wuelnerdotexe.plugin.util").add_colorscheme_integration("highlight-undo") end,
  config = function()
    require("highlight-undo").setup({
      duration = 125,
      keymaps = { { "n", "u", "undo", {} }, { "n", "<C-r>", "redo", {} } },
    })
  end,
}
