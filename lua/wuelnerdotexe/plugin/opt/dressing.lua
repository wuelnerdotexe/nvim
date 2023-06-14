return {
  "stevearc/dressing.nvim",
  lazy = true,
  init = function()
    require("wuelnerdotexe.plugin.util").set_option("winblend", require("wuelnerdotexe.plugin.config").blend)
    require("wuelnerdotexe.plugin.util").set_option("pumblend", require("wuelnerdotexe.plugin.config").blend)

    vim.ui.input = function(...)
      if package.loaded["dressing.nvim"] then return vim.ui.input(...) end

      require("lazy").load({ plugins = { "dressing.nvim" } })

      return vim.ui.input(...)
    end

    vim.ui.select = function(...)
      if package.loaded["dressing.nvim"] then return vim.ui.select(...) end

      require("lazy").load({ plugins = { "dressing.nvim" } })

      return vim.ui.select(...)
    end
  end,
  config = function()
    local border = require("wuelnerdotexe.plugin.config").border and "rounded" or "shadow"

    require("dressing").setup({
      input = {
        insert_only = false,
        border = border,
        win_options = { wrap = true },
        override = function(conf)
          conf.col = -1
          conf.row = 0

          return conf
        end,
      },
      select = {
        backend = { "telescope", "fzf", "nui", "builtin" },
        nui = {
          win_options = {
            winblend = require("wuelnerdotexe.plugin.config").blend,
            cursorline = true,
            winhighlight = "CursorLine:PmenuSel",
          },
          border = { style = border },
        },
        builtin = {
          border = border,
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
