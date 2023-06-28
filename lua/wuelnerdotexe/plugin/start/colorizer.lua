return {
  "NvChad/nvim-colorizer.lua",
  cmd = { "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers", "ColorizerToggle" },
  event = "FileType css,sass,html,javascript,javascriptreact,typescriptreact",
  init = function() require("wuelnerdotexe.plugin.util").set_option("termguicolors", true) end,
  config = function()
    require("colorizer").setup({
      user_default_options = { names = false, RRGGBBAA = true, AARRGGBB = true, virtualtext = "▎" },
      filetypes = {
        css = { css_fn = true },
        sass = { sass = { enable = true } },
        html = { css_fn = true, tailwind = true },
        javascript = { css_fn = true, tailwind = true },
        javascriptreact = { css_fn = true, tailwind = true },
        typescriptreact = { css_fn = true, tailwind = true },
      },
    })

    vim.defer_fn(function() require("colorizer").attach_to_buffer(0) end, 0)
  end,
}
