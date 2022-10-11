local M = {}

M.config = function()
  require('illuminate').configure({
    delay = 40,
    filetypes_denylist = {
      'aerial',
      'checkhealth',
      'fern',
      'fugitive',
      'fugitiveblame',
      'lspinfo',
      'mason',
      'nerdterm',
      'null-ls-info',
      'packer',
      'qf',
      'TelescopePrompt'
    },
    max_file_lines = 400
  })
end

return M

