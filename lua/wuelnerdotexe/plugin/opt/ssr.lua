return {
  "cshuaimin/ssr.nvim",
  enabled = not require("wuelnerdotexe.plugin.config").minimal_setup,
  keys = {
    {
      "<leader>sr",
      function() require("ssr").open() end,
      desc = "General: [s]tructural search and [r]eplace in the current directory",
      mode = { "n", "x" },
    },
  },
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    require("ssr").setup({
      border = require("wuelnerdotexe.plugin.config").border and "rounded" or "none",
      keymaps = { replace_all = "<localleader>rr" },
    })
  end,
}
