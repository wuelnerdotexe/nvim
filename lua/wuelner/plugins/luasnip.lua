return {
  "L3MON4D3/LuaSnip",
  event = { "BufNewFile", "BufRead", "BufAdd" },
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
      event = "InsertEnter",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    "saadparwaiz1/cmp_luasnip",
  },
}
