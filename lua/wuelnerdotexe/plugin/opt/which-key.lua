return {
  "folke/which-key.nvim",
  event = "UIEnter",
  init = function()
    require("wuelnerdotexe.plugin.util").add_colorscheme_integration("which-key")

    require("wuelnerdotexe.plugin.util").set_option("timeout", true)
    require("wuelnerdotexe.plugin.util").set_option("timeoutlen", 600)
  end,
  config = function()
    require("which-key").setup({
      plugins = { spelling = { enabled = false } },
      window = { border = "rounded", winblend = 10 },
    })
  end,
}
