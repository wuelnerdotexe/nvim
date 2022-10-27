local M = {}

M.setup = function()
  vim.g.enfocado_style = "neon"
  vim.g.enfocado_plugins = {
    "aerial",
    "bufferline",
    "cmp",
    "dapui",
    "fern",
    "gitsigns",
    "glyph-palette",
    "illuminate",
    "indent-blankline",
    "lsp",
    "matchup",
    "packer",
    "telescope",
    "treesitter",
    "visual-multi",
  }
end

M.config = function()
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "enfocado",
    nested = true,
    callback = function()
      vim.cmd("highlight! link Whitespace DiagnosticError")

      if vim.fn.has("termguicolors") and vim.opt.termguicolors == true then
        vim.opt.winblend = 10
        vim.opt.pumblend = 10
      end
    end,
  })
end

return M
