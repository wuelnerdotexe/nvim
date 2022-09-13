local M = {}

M.config = function()
  local keymap = vim.keymap

  keymap.set('n', '<leader>tt', '<Plug>(NERDTermToggle)')
  keymap.set('t', '<leader>tt', '<Plug>(NERDTermToggle)')
end

return M

