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
      buftypes = { "*" },
      filetypes = { "*", "!aerial", "!checkhealth", "!neo-tree", "!lazy", "!lspinfo", "!mason", "!null-ls-info" },
    })
  end,
}
