local M = {}

M.setup = function()
  local g = vim.g
  g.enfocado_style = 'neon'

  g.enfocado_plugins = {
    'bufferline',
    'cmp',
    'dashboard',
    'fern',
    'fzf',
    'glyph-palette',
    'illuminate',
    'indent-blankline',
    'lsp',
    'matchup',
    'packer',
    'treesitter',
    'visual-multi'
  }
end

M.config = function()
  local api = vim.api

  api.nvim_create_autocmd('VimEnter', {
    pattern = '*', nested = true, command = 'colorscheme enfocado'
  })

  api.nvim_create_autocmd('ColorScheme', {
    pattern = 'enfocado',
    nested = true,
    command = 'hi! link Whitespace DiagnosticError'
  })
end

return M

