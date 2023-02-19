return {
  "williamboman/mason.nvim",
  lazy = true,
  config = function() require("mason").setup({ ui = { border = require("wuelnerdotexe.plugin.configs").border.style } }) end,
}
