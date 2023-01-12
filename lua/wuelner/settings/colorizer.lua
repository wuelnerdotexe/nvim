require("colorizer").setup({
  user_default_options = {
    names = false,
    RRGGBBAA = true,
    AARRGGBB = true,
    css_fn = true,
    tailwind = "both",
    sass = { enable = true, parsers = { css } },
  },
  filetypes = { "*" },
  buftypes = { "*", "!nofile", "!prompt", "!terminal" },
})
