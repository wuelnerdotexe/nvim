local M = {}

M.config = function()
  require("colorizer").setup({
    user_default_options = {
      names = false,
      RRGGBBAA = true,
      AARRGGBB = true,
      css_fn = true,
      tailwind = "both",
      sass = { enable = true, parsers = { css } },
    },
    buftypes = { "*", "!nofile", "!prompt" },
    filetypes = { "*", "!TelescopePrompt" },
  })
end

return M
