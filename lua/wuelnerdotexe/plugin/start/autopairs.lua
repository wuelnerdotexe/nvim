local mode = { "i", "c" }

return {
  "altermo/npairs-integrate-upair",
  lazy = true,
  keys = {
    { "{", mode = mode },
    { "[", mode = mode },
    { "(", mode = mode },
    { '"', mode = mode },
    { "'", mode = mode },
    { "`", mode = mode },
    { "<CR>", mode = "i" },
    { "<BS>", mode = "i" },
    { "<A-e>", mode = "i" },
    { "<A-E>", mode = "i" },
    { "<A-]>", mode = "i" },
    { "<A-C-e>", mode = "i" },
    { "<Space>", mode = "i" },
  },
  dependencies = {
    { "windwp/nvim-autopairs", dependencies = "nvim-treesitter/nvim-treesitter" },
    { "altermo/ultimate-autopair.nvim", dependencies = "nvim-treesitter/nvim-treesitter" },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "IntPairsComp",
      callback = function()
        if not package.loaded["npairs-int-upair"] then
          require("lazy").load({ plugins = { "npairs-integrate-upair" } })
        end

        require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

        return true
      end,
    })
  end,
  config = function()
    local ignored_file_types = {}
    local disable = { disable = true }

    for _, uifiletype in pairs(require("wuelnerdotexe.plugin.config").uifiletypes) do
      ignored_file_types[uifiletype] = disable
    end

    require("npairs-int-upair").setup({
      bs = "u",
      npairs_conf = {
        disable_filetype = require("wuelnerdotexe.plugin.config").uifiletypes,
        check_ts = true,
        fast_wrap = { highlight = "Question", highlight_grey = "Dimmed" },
      },
      upair_conf = { internal_pairs = { ft = ignored_file_types } },
    })
  end,
}
