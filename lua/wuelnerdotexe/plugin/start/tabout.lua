return {
  "abecodes/tabout.nvim",
  dependencies = "nvim-treesitter/nvim-treesitter",
  cmd = { "Tabout", "TaboutBack", "TaboutToggle" },
  lazy = true,
  config = function()
    require("tabout").setup({
      tabkey = "",
      backwards_tabkey = "",
      ignore_beginning = false,
      exclude = {
        "aerial",
        "checkhealth",
        "dapui_breakpoints",
        "dapui_console",
        "dapui_scopes",
        "dapui_stacks",
        "DressingSelect",
        "help",
        "lazy",
        "lspinfo",
        "man",
        "mason",
        "netrw",
        "null-ls-info",
        "qf",
      },
    })
  end,
}
