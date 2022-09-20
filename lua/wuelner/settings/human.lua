local M = {}

M.setup = function()
  vim.g.bufonly_exclude_filetypes = { 'fern', 'nerdterm' }
end

M.config = function()
  local keymap_set = vim.keymap.set

  keymap_set('n', '1b', '<Plug>(BufOnly)')
  keymap_set('n', '<C-h>', '<Plug>(ResizerLeft)')
  keymap_set('n', '<C-j>', '<Plug>(ResizerDown)')
  keymap_set('n', '<C-k>', '<Plug>(ResizerUp)')
  keymap_set('n', '<C-l>', '<Plug>(ResizerRight)')
  keymap_set('n', '<leader>mt', '<Plug>(MaximizerToggle)')
end

return M

