local M = {}

M.setup = function()
  if vim.fn.executable('fd') == 1
  then
    vim.env.FZF_DEFAULT_COMMAND = 'fd -I -H -E "{' ..
      '.git,.svn,.hg,CSV,.DS_Store,Thumbs.db,' ..
      'node_modules,bower_components,*.code-search' ..
    '}" -t f'
  end
end

M.config = function()
  vim.keymap.set('n', '<leader>ff', '<Cmd>FZF<CR>', { silent = true })
end

return M

