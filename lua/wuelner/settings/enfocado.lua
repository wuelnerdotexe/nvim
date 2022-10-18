local M = {}

M.setup = function()
  local vim_g = vim.g

  vim_g.enfocado_style = "nature"
  vim_g.enfocado_plugins = {
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

      local vim_opt = vim.opt

      if vim.fn.has("termguicolors") and vim_opt.termguicolors == true then
        vim_opt.winblend = 10
        vim_opt.pumblend = 10
      end
    end,
  })
end

return M
