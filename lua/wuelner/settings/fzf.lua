local M = {}

M.setup = function()
  local vim_env = vim.env
  local vim_fn = vim.fn

  if vim_fn.executable('fd') == 1
  then
    vim_env.FZF_DEFAULT_COMMAND = 'fd -I -H ' ..
      '-E ".git" -E ".svn" -E ".hg" -E "CSV" -E ".DS_Store" -E "Thumbs.db" ' ..
      '-E "node_modules" -E "bower_components" -E "*.code-search" ' ..
    '-t f'
  end

  vim.keymap.set('n', '<leader>ff', '<Cmd>FZF<CR>', { silent = true })
end

return M

