return {
  "NvChad/nvim-colorizer.lua",
  event = require("wuelnerdotexe.plugin.config").open_file_event,
  init = function() require("wuelnerdotexe.plugin.util").set_option("termguicolors", true) end,
  config = function()
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

    vim.defer_fn(function() require("colorizer").attach_to_buffer(0) end, 0)
  end,
}
