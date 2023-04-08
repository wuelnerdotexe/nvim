return {
  "wuelnerdotexe/vim-enfocado",
  lazy = false,
  priority = 1000,
  init = function()
    require("wuelnerdotexe.plugin.util").set_option("termguicolors", true)
    require("wuelnerdotexe.plugin.util").set_option("t_Co", 256)
    require("wuelnerdotexe.plugin.util").set_option("background", "dark")

    vim.api.nvim_set_var("enfocado_plugins", {
      "aerial",
      "bufferline",
      "cmp",
      "dap-ui",
      "gitsigns",
      "illuminate",
      "indent-blankline",
      "lazy",
      "lspconfig",
      "matchup",
      "neo-tree",
      "noice",
      "null-ls",
      "smoothcursor",
      "substitute",
      "surround",
      "telescope",
      "treesitter",
      "ts-rainbow2",
      "visual-multi",
      "yanky",
    })
  end,
  config = function() vim.api.nvim_command("colorscheme enfocado") end,
}
