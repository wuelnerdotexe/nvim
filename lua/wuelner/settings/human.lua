local M = {}

M.config = function()
  vim.keymap.set('n', '<leader>mt', '<Plug>(MaximizerToggle)')
end

return M

