return {
  {
    {
      "windwp/nvim-autopairs",
      keys = {
        { "<M-e>", mode = "i" },
        { "<CR>", mode = "i" },
        { "{", mode = "i" },
        { "[", mode = "i" },
        { "(", mode = "i" },
        { '"', mode = "i" },
        { "'", mode = "i" },
        { "`", mode = "i" },
        { "<", mode = "i" },
      },
      lazy = true,
      init = function()
        vim.api.nvim_create_autocmd("User", {
          pattern = "IntPairsComp",
          callback = function()
            require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
          end,
          once = true,
        })
      end,
      config = function()
        require("nvim-autopairs").setup({
          map_bs = false,
          disable_filetype = require("wuelnerdotexe.plugin.util").user_interface_filetypes,
          check_ts = true,
          fast_wrap = { highlight = "Question", highlight_grey = "LspCodeLens" },
        })
      end,
    },
    {
      "hrsh7th/nvim-cmp",
      optional = true,
      opts = function()
        require("cmp").event:on("menu_opened", function()
          if vim.api.nvim_get_mode().mode:sub(1, 1) ~= "c" then
            vim.api.nvim_exec_autocmds("User", { pattern = "IntPairsComp", modeline = false })
          end
        end)
      end,
    },
  },
  {
    "altermo/ultimate-autopair.nvim",
    keys = {
      { "<A-)>", mode = { "i", "c" } },
      { "<BS>", mode = { "i", "c" } },
      { "<Space>", mode = { "i", "c" } },
      { "{", mode = "c" },
      { "[", mode = "c" },
      { "(", mode = "c" },
      { '"', mode = "c" },
      { "'", mode = "c" },
      { "`", mode = "c" },
    },
    lazy = true,
    config = function()
      require("ultimate-autopair").setup({
        pair_map = false,
        cr = { enable = false },
        space2 = { enable = true },
        fastwarp = { enable = false },
        extensions = { filetype = { nft = require("wuelnerdotexe.plugin.util").user_interface_filetypes } },
      })
    end,
  },
}
