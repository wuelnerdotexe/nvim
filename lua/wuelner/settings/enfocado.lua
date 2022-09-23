local M = {}

M.setup = function()
  local vim_g = vim.g

  vim_g.enfocado_style = 'neon'

  vim_g.enfocado_plugins = {
    'bufferline',
    'cmp',
    'fern',
    'fzf',
    'gitsigns',
    'glyph-palette',
    'illuminate',
    'indent-blankline',
    'lsp',
    'matchup',
    'packer',
    'treesitter',
    'visual-multi'
  }

  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'enfocado',
    command = 'highlight! link Whitespace DiagnosticError'
  })
end

return M

