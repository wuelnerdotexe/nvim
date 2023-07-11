return {
  "NvChad/nvim-colorizer.lua",
  cmd = { "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers", "ColorizerToggle" },
  ft = { "css", "sass", "html", "javascript", "javascriptreact", "typescriptreact" },
  init = function() require("wuelnerdotexe.plugin.util").set_option("termguicolors", true) end,
  opts = {
    user_default_options = { names = false, RRGGBBAA = true, AARRGGBB = true, virtualtext = "▎" },
    filetypes = {
      css = { css_fn = true },
      sass = { sass = { enable = true } },
      html = { css_fn = true, tailwind = "lsp" },
      javascript = { css_fn = true, tailwind = "lsp" },
      javascriptreact = { css_fn = true, tailwind = "lsp" },
      typescriptreact = { css_fn = true, tailwind = "lsp" },
    },
  },
  config = function(_, opts)
    require("colorizer").setup(opts)

    vim.defer_fn(function() require("colorizer").attach_to_buffer(0) end, 0)
  end,
}
