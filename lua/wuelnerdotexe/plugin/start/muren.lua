return {
  "AckslD/muren.nvim",
  cmd = { "MurenOpen", "MurenClose", "MurenToggle", "MurenFresh", "MurenUnique" },
  config = function()
    require("muren").setup({
      keys = { toggle_options_focus = "<C-o>", scroll_preview_up = "<C-b>", scroll_preview_down = "<C-f>" },
      hl = {
        options = { on = "DiagnosticOk", off = "DiagnosticError" },
        preview = { cwd = { path = "Directory", lnum = "LineNr" } },
      },
    })
  end,
}
