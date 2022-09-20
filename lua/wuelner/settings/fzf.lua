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
  elseif vim_fn.has('win32') ~= 1 and vim_fn.has('win32unix') ~= 1
  then
    vim_env.FZF_DEFAULT_COMMAND = [[find -not \( ]] ..
        [[-type d -name ".git" -prune -o ]] ..
        [[-type d -name ".svn" -prune -o ]] ..
        [[-type d -name ".hg" -prune -o ]] ..
        [[-type d -name "CSV" -prune -o ]] ..
        [[-type d -name ".DS_Store" -prune -o ]] ..
        [[-type d -name "Thumbs.db" -prune -o ]] ..
        [[-type d -name "node_modules" -prune ]] ..
        [[-type d -name "bower_components" -prune ]] ..
        [[-type d -name "*.code_search" -prune ]] ..
      [[ \) -type f -printf "%P\n"]]
  end

  vim.keymap.set('n', '<leader>ff', '<Cmd>FZF<CR>', { silent = true })
end

return M

