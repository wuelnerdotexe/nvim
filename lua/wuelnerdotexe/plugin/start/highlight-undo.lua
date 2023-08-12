return {
  "tzachar/highlight-undo.nvim",
  keys = { "u", "<C-r>" },
  config = function()
    require("highlight-undo").setup({
      duration = 125,
      undo = { hlgroup = "DiagnosticVirtualTextError" },
      redo = { hlgroup = "DiagnosticVirtualTextOk" },
    })
  end,
}
