local M = {}

M.setup = function()
  local fn = vim.fn
  local env = vim.env

  if fn.executable('fd') == 1 then
    env.FZF_DEFAULT_COMMAND = 'fd -I -H -E ".git" -E "node_modules" -t f'
  elseif fn.has('win32') ~= 1 and fn.has('win32unix') ~= 1 then
    env.FZF_DEFAULT_COMMAND = [[find -not \( ]] ..
        [[-type d -name ".git" -prune -o ]] ..
        [[-type d -name "node_modules" -prune ]] ..
      [[ \) -type f -printf "%P\n"]]
  end

  -- vim.g.fzf_layout = { down = '25%' }

  vim.keymap.set('n', '<leader>ff', '<Cmd>FZF<CR>', { silent = true })
end

return M

