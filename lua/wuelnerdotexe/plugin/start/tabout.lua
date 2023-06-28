return {
  "abecodes/tabout.nvim",
  dependencies = "nvim-treesitter/nvim-treesitter",
  cmd = { "Tabout", "TaboutBack", "TaboutToggle" },
  lazy = true,
  config = function()
    require("tabout").setup({ tabkey = "", backwards_tabkey = "", ignore_beginning = false, exclude = { "netrw" } })
  end,
}
