return {
  "gbprod/substitute.nvim",
  enabled = not require("wuelnerdotexe.plugin.config").minimal_setup,
  keys = {
    { "s", function() require("substitute").operator() end },
    { "ss", function() require("substitute").line() end },
    { "S", function() require("substitute").eol() end },
    { "s", function() require("substitute").visual() end, mode = "x" },
    { "sx", function() require("substitute.exchange").operator() end },
    { "sxx", function() require("substitute.exchange").line() end },
    { "X", function() require("substitute.exchange").visual() end, mode = "x" },
  },
  dependencies = "gbprod/yanky.nvim",
  init = function()
    require("wuelnerdotexe.plugin.util").set_option("clipboard", "unnamedplus")

    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function() vim.api.nvim_command("highlight! link SubstituteSubstituted TextYanked") end,
    })
  end,
  config = function()
    require("substitute").setup({
      on_substitute = require("yanky.integration").substitute(),
      yank_substituted_text = true,
      highlight_substituted_text = { timer = 125 },
    })
  end,
}
