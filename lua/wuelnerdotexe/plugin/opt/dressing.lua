return {
  "stevearc/dressing.nvim",
  enabled = not require("wuelnerdotexe.plugin.config").minimal_setup,
  event = "VeryLazy",
  config = function()
    local borderstyle = require("wuelnerdotexe.plugin.util").get_border().style

    require("dressing").setup({
      input = {
        insert_only = false,
        border = borderstyle,
        win_options = { wrap = true },
        override = function(conf)
          conf.col = -1
          conf.row = 0

          return conf
        end,
      },
      select = {
        backend = { "nui", "builtin" },
        nui = {
          win_options = {
            winblend = require("wuelnerdotexe.plugin.config").blend,
            cursorline = true,
            winhighlight = "CursorLine:PmenuSel",
          },
          border = { style = borderstyle },
        },
        builtin = {
          border = borderstyle,
          win_options = {
            winblend = require("wuelnerdotexe.plugin.config").blend,
            cursorline = true,
            winhighlight = "CursorLine:PmenuSel",
          },
        },
      },
    })
  end,
}