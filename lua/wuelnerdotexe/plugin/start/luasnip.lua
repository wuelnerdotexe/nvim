return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  keys = {
    {
      "<Tab>",
      function() return require("luasnip").expand_or_jumpable() and "<Plug>luasnip-expand-or-jump" or "<Plug>(Tabout)" end,
      expr = true,
      mode = "i",
    },
    { "<Tab>", function() require("luasnip").jump(1) end, mode = "s" },
    {
      "<S-Tab>",
      function() return require("luasnip").jumpable(-1) and "<Plug>luasnip-jump-prev" or "<Plug>(TaboutBack)" end,
      expr = true,
      mode = "i",
    },
    { "<S-Tab>", function() require("luasnip").jump(-1) end, mode = "s" },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    {
      "rafamadriz/friendly-snippets",
      config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
    },
    {
      "abecodes/tabout.nvim",
      dependencies = "nvim-treesitter/nvim-treesitter",
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
            "null-ls-info",
            "qf",
          },
        })
      end,
    },
  },
  config = function()
    require("luasnip").setup({
      history = true,
      region_check_events = { "CursorMoved", "CursorMovedI" },
      delete_check_events = { "TextChanged", "TextChangedI" },
    })
  end,
}
