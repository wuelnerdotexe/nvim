return {
  "wuelnerdotexe/vim-enfocado",
  priority = 1000,
  lazy = false,
  init = function()
    require("wuelnerdotexe.plugin.util").set_option("termguicolors", true)
    require("wuelnerdotexe.plugin.util").set_option("t_Co", 256)
    require("wuelnerdotexe.plugin.util").set_option("background", "dark")

    vim.api.nvim_set_var("enfocado_plugins", {
      "aerial",
      "bufferline",
      "cmp",
      "dap-ui",
      "fold-preview",
      "fzf",
      "gitsigns",
      "illuminate",
      "indent-blankline",
      "lazy",
      "lspconfig",
      "mason",
      "neo-tree",
      "netrw",
      "noice",
      "null-ls",
      "substitute",
      "surround",
      "telescope",
      "treesitter",
      "ts-rainbow2",
      "visual-multi",
      "yanky",
    })

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "enfocado",
      callback = function() vim.api.nvim_set_hl(0, "NormalNC", { bg = "#1e1e1e" }) end,
    })
  end,
  config = function() vim.api.nvim_command("colorscheme enfocado") end,
}
