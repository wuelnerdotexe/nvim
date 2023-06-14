local mode = { "n", "x" }

return {
  "gbprod/yanky.nvim",
  keys = {
    { "y", "<Plug>(YankyYank)", mode = mode },
    { "p", "<Plug>(YankyPutAfter)", mode = mode },
    { "P", "<Plug>(YankyPutBefore)", mode = mode },
    { "<C-Left>", "<Plug>(YankyCycleBackward)" },
    { "<C-Right>", "<Plug>(YankyCycleForward)" },
  },
  cmd = { "YankyClearHistory", "YankyRingHistory" },
  lazy = true,
  config = function()
    require("yanky").setup({ picker = { telescope = { use_default_mappings = false } }, highlight = { timer = 125 } })
  end,
}
