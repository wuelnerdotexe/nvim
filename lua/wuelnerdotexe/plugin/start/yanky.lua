return {
  "gbprod/yanky.nvim",
  keys = {
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" } },
    { "p", function() require("yanky").put("p", false) end },
    { "p", function() require("yanky").put("p", true) end, mode = "x" },
    { "P", function() require("yanky").put("P", false) end },
    { "P", function() require("yanky").put("P", true) end, mode = "x" },
    { "<C-Right>", function() require("yanky").cycle(1) end },
    { "<C-Left>", function() require("yanky").cycle(-1) end },
  },
  cmd = { "YankyClearHistory", "YankyRingHistory" },
  lazy = true,
  init = function() require("wuelnerdotexe.plugin.util").add_colorscheme_integration("yanky") end,
  config = function()
    require("yanky").setup({ picker = { telescope = { use_default_mappings = false } }, highlight = { timer = 125 } })
  end,
}
