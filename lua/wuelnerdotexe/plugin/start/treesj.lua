return {
  "Wansmer/treesj",
  keys = { { "J", function() vim.api.nvim_command("TSJToggle") end } },
  dependencies = "nvim-treesitter",
  config = function() require("treesj").setup({ use_default_keymaps = false }) end,
}
