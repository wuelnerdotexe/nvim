return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  event = "UIEnter",
  config = function()
    require("hardtime").setup({
      max_time = vim.api.nvim_get_option_value("timeoutlen", { scope = "global" }),
      disabled_filetypes = require("wuelnerdotexe.plugin.util").user_interface_filetypes,
    })
  end,
}
