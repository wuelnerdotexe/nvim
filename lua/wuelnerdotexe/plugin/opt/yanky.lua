local mode = { "n", "x" }

return {
  "gbprod/yanky.nvim",
  enabled = not require("wuelnerdotexe.plugin.config").minimal_setup,
  keys = {
    { "y", "<Plug>(YankyYank)", mode = mode },
    { "p", "<Plug>(YankyPutAfter)", mode = mode },
    { "P", "<Plug>(YankyPutBefore)", mode = mode },
    { "<C-Left>", "<Plug>(YankyCycleBackward)" },
    { "<C-Right>", "<Plug>(YankyCycleForward)" },
  },
  init = function() require("wuelnerdotexe.plugin.util").set_option("clipboard", "unnamedplus") end,
  config = function() require("yanky").setup({ highlight = { timer = 125 } }) end,
}
