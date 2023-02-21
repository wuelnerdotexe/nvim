return {
  "williamboman/mason.nvim",
  lazy = true,
  config = function() require("mason").setup({ ui = { border = require("wuelnerdotexe.plugin.util").get_border().chars } }) end,
}
