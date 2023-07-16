return {
  {
    "altermo/npairs-integrate-upair",
    dependencies = { "windwp/nvim-autopairs", "altermo/ultimate-autopair.nvim" },
    keys = {
      { "<A-C-e>", mode = "i" },
      { "<A-e>", mode = "i" },
      { "<A-E>", mode = "i" },
      { "<A-]>", mode = "i" },
      { "<A-)>", mode = "i" },
      { "<CR>", mode = "i" },
      { "<BS>", mode = { "i", "c" } },
      { "<Space>", mode = { "i", "c" } },
      { "{", mode = { "i", "c" } },
      { "[", mode = { "i", "c" } },
      { "(", mode = { "i", "c" } },
      { '"', mode = { "i", "c" } },
      { "'", mode = { "i", "c" } },
      { "`", mode = { "i", "c" } },
    },
    lazy = true,
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "IntPairsComp",
        callback = function()
          if not package.loaded["npairs-int-upair"] then
            require("lazy").load({ plugins = { "npairs-integrate-upair" } })
          end

          require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
        end,
        once = true,
      })
    end,
    config = function()
      require("npairs-int-upair").setup({
        bs = "u",
        npairs_conf = {
          disable_filetype = require("wuelnerdotexe.plugin.util").user_interface_filetypes,
          check_ts = true,
          fast_wrap = { highlight = "Question", highlight_grey = "LspCodeLens" },
        },
        upair_conf = {
          extensions = { filetype = { nft = require("wuelnerdotexe.plugin.util").user_interface_filetypes } },
        },
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
}
