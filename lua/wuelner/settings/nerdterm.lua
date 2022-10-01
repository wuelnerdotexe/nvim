local M = {}

M.config = function()
  NERDTermToggleWithBufresize = function()
    local bufresize = require('bufresize')
    local command = vim.api.nvim_command

    if vim.bo.filetype == 'nerdterm'
    then
      bufresize.block_register()
      command('NERDTermToggle')
      bufresize.resize_close()
    else
      bufresize.block_register()
      command('NERDTermToggle')
      bufresize.resize_open()
    end
  end

  local keymap_set = vim.keymap.set

  keymap_set('n', '<leader>tt', '<Cmd>lua NERDTermToggleWithBufresize()<CR>')
  keymap_set('t', '<leader>tt', '<Cmd>lua NERDTermToggleWithBufresize()<CR>')
end

return M

