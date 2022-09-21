local M = {}

M.setup = function()
  local vim_g = vim.g

  vim_g.enfocado_style = 'neon'

  vim_g.enfocado_plugins = {
    'bufferline',
    'cmp',
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
  local create_autocmd = vim.api.nvim_create_autocmd

  create_autocmd('VimEnter', {
    pattern = '*', nested = true, command = 'colorscheme enfocado'
  })

  create_autocmd('ColorScheme', {
    pattern = 'enfocado',
    nested = true,
    command = 'highlight! link Whitespace DiagnosticError'
  })
end

return M

