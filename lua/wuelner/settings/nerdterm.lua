local M = {}

M.config = function()
  ToggleNERDTerm = function(cmd)
    local bufresize = require('bufresize')
    local command = vim.api.nvim_command

    if vim.bo.filetype == 'nerdterm'
    then
      bufresize.block_register()
      command(cmd)
      bufresize.resize_close()
    else
      bufresize.block_register()
      command(cmd)
      bufresize.resize_open()
      vim.cmd('execute "normal! i"')
    end
  end

  local keymap_set = vim.keymap.set

  keymap_set('n', '<leader>tt', '<Cmd>lua ToggleNERDTerm("NERDTermToggle")<CR>')
  keymap_set('t', '<leader>tt', '<Cmd>lua ToggleNERDTerm("NERDTermToggle")<CR>')
end

return M

