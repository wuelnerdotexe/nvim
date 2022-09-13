local M = {}

M.config = function()
  require('illuminate').configure({
    filetypes_denylist = {
      'checkhealth',
      'dashboard',
      'fern',
      'fugitive',
      'fugitiveblame',
      'help',
      'lspinfo',
      'mason',
      'packer',
      'null-ls-info'
    }
  })
end

return M

