local M = {}

M.config = function()
  require('illuminate').configure({
    filetypes_denylist = {
      'checkhealth',
      'fern',
      'fugitive',
      'fugitiveblame',
      'fzf',
      'lspinfo',
      'mason',
      'nerdterm',
      'packer',
      'qf',
      'null-ls-info'
    }
  })
end

return M

