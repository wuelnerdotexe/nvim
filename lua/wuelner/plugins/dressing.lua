return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  config = function()
    require("dressing").setup({
      input = {
        insert_only = false,
        win_options = { wrap = true },
        override = function(conf)
          conf.col = -1
          conf.row = 0

          return conf
        end,
      },
      select = {
        backend = { "nui", "builtin" },
        nui = { win_options = { cursorline = true, winhighlight = "CursorLine:PmenuSel" } },
        builtin = { win_options = { cursorline = true, winhighlight = "CursorLine:PmenuSel" } },
      },
    })
  end,
}
