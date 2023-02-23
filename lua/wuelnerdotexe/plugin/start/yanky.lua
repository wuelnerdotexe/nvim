local mode = { "n", "x" }

return {
  "gbprod/yanky.nvim",
  keys = {
    { "y", "<Plug>(YankyYank)", mode = mode },
    { "p", "<Plug>(YankyPutAfter)", mode = mode },
    { "P", "<Plug>(YankyPutBefore)", mode = mode },
    { "gp", "<Plug>(YankyGPutAfter)", mode = mode },
    { "gP", "<Plug>(YankyGPutBefore)", mode = mode },
    { "<C-Left>", "<Plug>(YankyCycleBackward)" },
    { "<C-Right>", "<Plug>(YankyCycleForward)" },
  },
  config = function() require("yanky").setup({ highlight = { timer = 125 } }) end,
}
