return {
  "lukas-reineke/headlines.nvim",
  dependencies = "nvim-treesitter/nvim-treesitter",
  ft = { "markdown", "org", "norg" },
  init = function() require("wuelnerdotexe.plugin.util").add_colorscheme_integration("headlines") end,
  config = function()
    local headline_highlights =
      { headline_highlights = { "Headline1", "Headline2", "Headline3", "Headline4", "Headline5", "Headline6" } }

    require("headlines").setup({ markdown = headline_highlights, org = headline_highlights, norg = headline_highlights })
  end,
}
