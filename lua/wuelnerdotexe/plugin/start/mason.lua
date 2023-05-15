return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  lazy = true,
  config = function()
    require("mason").setup({ ui = { border = require("wuelnerdotexe.plugin.config").border and "rounded" or "none" } })
  end,
}
