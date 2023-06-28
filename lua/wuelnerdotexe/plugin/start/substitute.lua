return {
  "gbprod/substitute.nvim",
  keys = {
    { "s", function() require("substitute").operator() end },
    { "ss", function() require("substitute").line() end },
    { "S", function() require("substitute").eol() end },
    { "s", function() require("substitute").visual() end, mode = "x" },
    { "sx", function() require("substitute.exchange").operator() end },
    { "sxx", function() require("substitute.exchange").line() end },
    { "X", function() require("substitute.exchange").visual() end, mode = "x" },
  },
  init = function()
    require("wuelnerdotexe.plugin.util").add_colorscheme_integration("substitute")

    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function() vim.api.nvim_set_hl(0, "SubstituteSubstituted", { reverse = true }) end,
    })
  end,
  config = function()
    require("substitute").setup({
      on_substitute = pcall(require, "yanky.integration") and require("yanky.integration").substitute() or nil,
      yank_substituted_text = true,
      highlight_substituted_text = { timer = 125 },
    })
  end,
}
