return {
  "NvChad/nvim-colorizer.lua",
  event = require("wuelnerdotexe.plugin.config").open_file_event,
  config = function()
    vim.api.nvim_set_option_value("termguicolors", true, require("wuelnerdotexe.plugin.util").empty_table)

    require("colorizer").setup({
      user_default_options = {
        names = false,
        RRGGBBAA = true,
        AARRGGBB = true,
        css_fn = true,
        tailwind = "both",
        sass = { enable = true, parsers = { css = true } },
      },
      filetypes = { "*" },
      buftypes = { "*", "!nofile", "!prompt", "!terminal" },
    })
  end,
}
