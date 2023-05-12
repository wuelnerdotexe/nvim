return {
  "williamboman/mason.nvim",
  lazy = true,
  config = function()
    require("mason").setup({ ui = { border = require("wuelnerdotexe.plugin.config").border and "rounded" or "none" } })
  end,
}
