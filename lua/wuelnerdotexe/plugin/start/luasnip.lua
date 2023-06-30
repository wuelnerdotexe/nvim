return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
  },
  keys = {
    {
      "<Tab>",
      function()
        if require("luasnip").expand_or_locally_jumpable() then
          require("luasnip").expand_or_jump()

          return
        end

        if pcall(require, "tabout") then
          require("tabout").tabout()

          return
        end

        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "i", false)
      end,
      mode = "i",
    },
    { "<Tab>", function() require("luasnip").jump(1) end, mode = "s" },
    {
      "<S-Tab>",
      function()
        if require("luasnip").locally_jumpable(-1) then
          require("luasnip").jump(-1)

          return
        end

        if pcall(require, "tabout") then
          require("tabout").taboutBack()

          return
        end

        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true), "i", false)
      end,
      mode = "i",
    },
    { "<S-Tab>", function() require("luasnip").jump(-1) end, mode = "s" },
  },
  cmd = { "LuaSnipListAvailable", "LuaSnipUnlinkCurrent" },
  config = function()
    require("luasnip").setup({
      history = true,
      region_check_events = { "CursorMoved", "CursorMovedI" },
      delete_check_events = { "TextChanged", "TextChangedI" },
    })
  end,
}
