return {
  "NvChad/nvim-colorizer.lua",
  event = {
    "BufAdd *.css,*.sass,*.html,*.js,*.jsx,*.tsx",
    "BufReadPre *.css,*.sass,*.html,*.js,*.jsx,*.tsx",
    "BufNewFile *.css,*.sass,*.html,*.js,*.jsx,*.tsx",
  },
  -- event = "FileType css,sass,html,javascript,javascriptreact,typescriptreact",
  init = function() require("wuelnerdotexe.plugin.util").set_option("termguicolors", true) end,
  config = function()
    local css_tailwind_setup = { css_fn = true, tailwind = true }

    require("colorizer").setup({
      user_default_options = { names = false, RRGGBBAA = true, AARRGGBB = true, virtualtext = "▎" },
      filetypes = {
        css = { css_fn = true },
        sass = { sass = { enable = true } },
        html = css_tailwind_setup,
        javascript = css_tailwind_setup,
        javascriptreact = css_tailwind_setup,
        typescriptreact = css_tailwind_setup,
      },
    })
  end,
}
