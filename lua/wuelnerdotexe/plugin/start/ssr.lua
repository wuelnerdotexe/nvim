return {
  "cshuaimin/ssr.nvim",
  keys = { { "<leader>sr", function() require("ssr").open() end, mode = { "n", "x" } } },
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    local sidebar_width = require("wuelnerdotexe.plugin.util").get_sidebar_width()

    require("ssr").setup({
      border = require("wuelnerdotexe.plugin.util").get_border().style,
      keymaps = { replace_all = "<localleader>rr" },
    })
  end,
}
