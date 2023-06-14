return {
  "Wansmer/treesj",
  dependencies = "nvim-treesitter/nvim-treesitter",
  keys = { { "J", function() require("treesj").toggle() end } },
  cmd = { "TSJJoin", "TSJSplit", "TSJToggle" },
  config = function() require("treesj").setup({ use_default_keymaps = false }) end,
}
