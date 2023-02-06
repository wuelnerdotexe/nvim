local mode = { "n", "x" }

return {
  "gbprod/yanky.nvim",
  keys = {
    { "y", "<Plug>(YankyYank)", mode = mode },
    { "P", "<Plug>(YankyPutBefore)", mode = mode },
    { "p", "<Plug>(YankyPutAfter)", mode = mode },
    { "<C-Left>", "<Plug>(YankyCycleBackward)" },
    { "<C-Right>", "<Plug>(YankyCycleForward)" },
  },
  config = function()
    require("yanky").setup({ highlight = { timer = 150 } })
  end,
}
