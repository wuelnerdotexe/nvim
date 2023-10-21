return {
  "lukas-reineke/headlines.nvim",
  dependencies = "nvim-treesitter/nvim-treesitter",
  ft = { "markdown", "orgmode", "neorg" },
  init = function() require("wuelnerdotexe.plugin.util").add_colorscheme_integration("headlines") end,
  config = function() require("headlines").setup() end,
}
