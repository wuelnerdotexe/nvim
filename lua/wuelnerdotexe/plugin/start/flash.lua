return {
  "folke/flash.nvim",
  keys = {
    { "<M-s>", function() require("flash").jump() end, mode = { "n", "x", "o" } },
    {
      "<M-v>",
      function()
        if pcall(require, "nvim-treesitter") then require("flash").treesitter() end
      end,
      mode = { "n", "x", "o" },
    },
    { "/", mode = { "n", "x", "o" } },
    { "?", mode = { "n", "x", "o" } },
  },
  init = function()
    require("wuelnerdotexe.plugin.util").add_colorscheme_integration("flash")

    table.insert(require("wuelnerdotexe.plugin.util").user_interface_filetypes, "flash_prompt")
  end,
  config = function()
    require("flash").setup({
      search = {
        incremental = vim.api.nvim_get_option_value("incsearch", { scope = "global" }),
        filetype_exclude = vim.list_extend({
          function(win) return not vim.api.nvim_win_get_config(win).focusable end,
        }, require("wuelnerdotexe.plugin.util").user_interface_filetypes),
      },
      label = { reuse = "all", rainbow = { enabled = true, shade = 9 } },
      modes = {
        search = { highlight = { backdrop = true } },
        char = { enabled = false },
        treesitter = { highlight = { backdrop = true } },
      },
    })
  end,
}
