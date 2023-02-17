return {
  "williamboman/mason.nvim",
  lazy = true,
  config = function()
    require("mason").setup({ ui = { border = require("wuelnerdotexe.utils").interface.border.style } })
  end,
}
